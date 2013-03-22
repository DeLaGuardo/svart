#### Any helper function ####
ss      = require 'socketstream'
postman = require 'postman'
bcrypt  = require 'bcrypt'
# ss.api.app.models.User    = ss.api.app.models.ss.api.app.models.User

forgottenPasswordEmailText = (link) -> "Hi,
  \n
  \nWe got a notification that you've forgotten your password. It's cool, we'll help you out.
  \n
  \nIf you wish to change your password, follow this link: #{link}
  \n
  \nRegards,
  \n
  \n  Dashku Admin"

forgottenPasswordEmailHtml = (link) -> "<p>Hi,</p>
  \n<p>We got a notification that you've forgotten your password. It's cool, we'll help you out.</p>
  \n<p>If you wish to change your password, follow this link: <a>#{link}</a></p>
  \n<p>Regards,</p>
  \n<p>  Dashku Admin</p>"

module.exports = (functions) ->
  functions.hashPassword = (password, cb) ->
    bcrypt.genSalt 10, (err, salt) ->
      bcrypt.hash password, salt, (err, hash) ->
        cb hash: hash, salt: salt

  functions.fetchUserFromSession = (req, res, next) ->
    # console.log req.session
    ss.api.app.models.User.findOne {_id: req.session.userId}, (err, user) ->
      console.log err, user
      if !err and user?
        next user
      else
        res status: 'failure', reason: err || "ss.api.app.models.User not found"

  functions.getUser = (data, callback) ->
    query = if data.identifier.match('@')?
              {email: data.identifier.toLowerCase()}
            else {username: data.identifier.toLowerCase()}
    ss.api.app.models.User.findOne query, (err, user) ->
      if err? or not user?
        return callback "пользователь #{data.identifier} не зарегистрирован"
      callback null, user

  functions.findOneUser = (query, callback) ->
    ss.api.app.models.User.findOne query, (err, user) ->
      if err?
        return callback err
      if not user?
        return callback -1
      callback null, user

  functions.findUsers = (query, callback) ->
    ss.api.app.models.User.find query, (err, users) ->
      if err? or users.length is 0
        return callback 'no users'
      callback null, users

  functions.saveUser = (user, callback) ->
    user.save (err, saved_user) ->
      if err?
        return callback err
      callback null, saved_user

  functions.changeToken = (user, callback) ->
    user.changePasswordToken = uuid.v4()
    user.save (err) ->
      if err?
        return callback err
      link = config[ss.env].forgottenPasswordUrl + user.changePasswordToken
      mailOptions =
        from: "ScholarMedia <admin@scholar.com>"
        to: user.email
        subject: "Forgotten Password"
        text: forgottenPasswordEmailText link
        html: forgottenPasswordEmailHtml link
      callback null, mailOptions

  functions.sendEmail = (mailOptions, callback) ->
    postman.sendMail mailOptions, (err, res) ->
      if err?
        return callback err
      callback null, res

  functions.comparePasswords = (user, data, callback) ->
    bcrypt.compare data.currentPassword, user.passwordHash, (err, authenticated) ->
      if authenticated
        return callback 'dismatch passwords'
      if data.newPassword is '' or not data.newPassword?
        return callback 'no password'
      hashPassword data.newPassword, (hashedPassword) ->
        user.passwordHash = hashedPassword.hash
        user.passwordSalt = hashedPassword.salt
        callback null, user, data
