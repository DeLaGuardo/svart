#### Authentication RPC module ####
# TODO: (delaguardo) Remove all (ALL!) functions from rpc actions.
#                    Never come close to DRY without that.
#                    Create async waterfall fabric.
#                    Change actions with 2 strings:
#                      * first for fabric
#                      * second for async callback propogation
# TODO: (delaguardo) Create widdleware for error nicer.
#                    Return `JSON.stringify err` like answer - make me sad.

bcrypt               = require 'bcrypt'
async                = require 'async'
ss                   = require 'socketstream'


User                 = ss.api.app.models.User
Redis                = ss.api.app.redis
config               = ss.api.app.config
functions            = ss.api.app.helpers.functions
# functions.fetchUserFromSession = ss.api.app.helpers.functions.functions.fetchUserFromSession

# Hashes & Salts the password
hashPassword = (password, cb) ->
  bcrypt.genSalt 10, (err, salt) -> bcrypt.hash password, salt, (err, hash) -> cb hash: hash, salt: salt

exports.actions = (req, res, ss) ->

  req.use 'session'

  # Sign up a new user
  signup: (data) ->
    getUserFromData = (callback) ->
      if not data?.username? or not data?.email? or not data?.password?
        return callback -1
      user = new User
        username: data.username
        email: data.email
        password: data.password
      callback null, user
    saveSession = (user, callback) ->
      Redis.hset 'apiKeys', user.apiKey, user.email
      console.log JSON.stringify user
      user_for_send =
        _id: user._id
        username: user.username
        email: user.email
      req.session.userId = user._id
      req.session.save (err) ->
        if err?
          return callback err
        callback null, user_for_send
    async.waterfall [
      getUserFromData
      functions.saveUser
      saveSession
      ], (err, result) ->
      if err? and err is -1
        return res status: 'failure', reason: "some input is invalid"
      else if err?
        if err.code is 11000
          reason = 'Такой email уже используется!'
        return res status: 'failure', reason: (reason || JSON.stringify err)
      res status: 'success', user: result

  # Check if a user is currently signed in, based on their session
  signedIn: ->
    functions.fetchUserFromSession req, res, (user) ->
      if user?
        req.session.channel.subscribe "user_#{user._id}"
        console.log user
        res
          status: 'success'
          user:
            id: user.id
            username: user.username
            email: user.email
            fb: (true if user.fb?) || (false if !user.fb?)
      res status: 'failure'

  #  Login an existing user
  login: (data) ->
    getQuery = (callback) ->
      if not data?
        return callback -1
      query = if data.identifier.match('@')?
                {email: data.identifier.toLowerCase()}
              else {username: data.identifier.toLowerCase()}
      callback null, query
    isAuthenticated = (user, callback) ->
      bcrypt.compare data.password, user.passwordHash, (err, authenticated) ->
        if not authenticated
          return callback "неверный пароль"
        req.session.userId = user._id
        callback null, req.session, user
    saveSession = (session, user, callback) ->
      session.save (err) ->
        if err?
          return callback err
        session.channel.subscribe "user_#{user._id}"
        callback null, user
    async.waterfall [
      getQuery
      functions.findOneUser
      isAuthenticated
      saveSession
    ], (err, user) ->
      if err? and err is -1
        return res status: 'failure', reason: "пользователь не зарегистрирован"
      else if err?
        return res status: 'failure', reason: err
      return res status: 'success', user: _id: user._id, username: user.username, email: user.email

  # Logout the user from the session
  logout: ->
    req.session.userId = null
    req.session.save (err) ->
      if err?
        return res status: 'failure', reason: JSON.stringify err
      req.session.channel.reset()
      res status: 'success'

  # Check if an attribute is unique, used by the signup form
  isAttributeUnique: (condition) ->
    User.findOne condition, (err, doc) -> res doc is null

  # Returns the account from the user session
  account: ->
    functions.fetchUserFromSession req, res, (user) ->
      Redis.hget 'apiUsage', user.apiKey, (err, apiUsage) ->
        if !err
          res status: 'success'
            , user: _id: user._id
            , username: user.username
            , firstname: user.firstname
            , lastname: user.lastname
            , fullname: user.fullname
            , email: user.email
            , apiUsage: apiUsage || 0

  # Generates an email and a forgotten password token, when the user has forgotten their password
  forgotPassword: (identifier) ->
    getQueryFromData = (callback) ->
      if not identifier?
        callback -1
      query = if identifier.match('@')?
                {email: identifier.toLowerCase()}
              else {username: identifier.toLowerCase()}
      callback null, query
    async.waterfall [
      getQueryFromData
      functions.findOneUser
      functions.changeToken
      functions.sendEmail
      ], (err, answer) ->
        if err?
          return res status: 'failure', reason: err
        res status: 'success', result: answer

  # Validates if the forgottenPasswordToken is valid
  loadChangePassword: (token) ->
    getQueryFromData = (callback) ->
      console.log '!'
      if not token?
        return callback -2
      callback null, {changePasswordToken: token}
    async.waterfall [
      getQueryFromData
      functions.findOneUser
      ], (err, user) ->
        if err? and err is -1
          return res status: 'failure', reason: 'No user found with that token'
        if err?
          return res status: 'failure', reason: JSON.stringify err
        res status: 'success', token: user.changePasswordToken

  # Changes the user's password, as part of the forgotten password user flow
  changePassword: (data) ->
    getQueryFromData = (callback) ->
      if not data?
        return callback 'no data'
      callback null, {changePasswordToken: data.token}
    setUserPass = (user, callback) ->
      if data.password is '' or not data.password?
        return callback 'no password'
      hashPassword data.password, (hashedPassword) ->
        user.passwordHash = hashedPassword.hash
        user.passwordSalt = hashedPassword.salt
        user.changePasswordToken = uuid.v4()
        callback null, user
    async.waterfall [
      getQueryFromData
      functions.findOneUser
      setUserPass
      functions.saveUser
      ], (err, saved_user) ->
        if err? and err is 'no data'
          return res status: 'failure', reason: "No user found with that token"
        if err? and err is 'no password'
          return res status: 'failure', reason: "new password was not supplied"
        if err?
          return res status: 'failure', reason: JSON.stringify err
        res status: 'success'

  # Changes the user's password, from the account page
  changeAccountPassword: (data) ->
    getUser = (callback) ->
      functions.fetchUserFromSession req, res, (user) ->
        if not user?
          return callback 'no user'
        callback null, user, data
    async.waterfall [
      getUser
      functions.comparePasswords
      functions.saveUser
      ], (err, status) ->
        if err? and err is 'no user'
          return res status: 'failure', reason: 'No user found'
        if err? and err is 'no password'
          return res status: 'failure', reason: 'new password was not supplied'
        if err? and err is 'dismatch passwords'
          return res status: 'failure', reason: 'Current password supplied was invalid'
        if err?
          return res status: 'failure', reason: JSON.stringify err
        res status: 'success'

  # Changes the user's email address, from the account page
  changeEmail: (data) ->
    functions.fetchUserFromSession req, res, (user) ->
      User.find {email: data.email}, (err, users) ->
        if !err
          if users.length is 0
            user.email = data.email
            user.save (err) ->
              if !err
                res status: 'success'
              else
                res status: 'failure', reason: err.message
          else
            res status: 'failure', reason: "Someone already has that email address."
        else
          res status: 'failure', reason: err

  # Delete's the user's account, if they have supplied their password
  cancelAccount: (data) ->
    functions.fetchUserFromSession req, res, (user) ->
      bcrypt.compare data.password, user.passwordHash, (err, authenticated) ->
        if authenticated
          req.session.userId = null
          req.session.save (err) ->
            if !err
              req.session.channel.reset()
              Dashboard.remove {userId: user._id}, (err) ->
                if !err
                  User.remove {_id: user._id}, (err) ->
                    if !err
                      res status: 'success'
                    else
                      res status: 'failure', reason: err
                else
                  res status: 'failure', reason: err
            else
              res status: 'failure', reason: err
        else
          res status: 'failure', reason: "Password invalid"
