#### User model ####

bcrypt      = require 'bcrypt'
mongoose    = require 'mongoose'
uuid        = require 'node-uuid'
ss          = require 'socketstream'

# User base schema
module.exports = (app) ->

  setters     = app.helpers.setters
  validators  = app.helpers.validators
  functions   = app.helpers.functions
  generators  = app.helpers.generators

  app.schemas.Users = new mongoose.Schema
    id                  : type: String, unique: yes
    username            :
                          type    : String
                          required: no
                          unique  : yes
                          set     : setters.setUsername
                          validate: [
                            validators.length_less('user','username')
                            validators.correctness('user','username') ]
    firstname           :
                          type    : String
                          required: no
                          # validate: validators.length_less('user','firstname')
    lastname            :
                          type    : String
                          required: no
                          # validate: validators.length_less('user','lastname')
    email               :
                          type    : String
                          required: yes
                          unique  : yes
                          sparse  : yes
                          set     : setters.setToLower
                          validate: [
                            validators.length_less('user','email')
                            validators.correctness('user','email') ]
    state               :
                          type    : String
                          required: yes
                          default : 'active'
                          enum    : ['active','hidden','deleted']
    files               :
                          type: [mongoose.Schema.ObjectId], ref: 'File'
    password            : String
    passwordHash        : String
    passwordSalt        : String
    created             : type: Date, default: Date.now
    updated             : type: Date, default: Date.now
    modified            : type: Date, default: Date.now
    state_changed_at    : type: Date, default: Date.now
    state_changed_by    : type: mongoose.Schema.ObjectId, ref: 'User'
    apiKey              : type: String, default: uuid.v4
    changePasswordToken : String
    versionKey          : false

  app.schemas.Users.virtual('fullname').get ->
    @firstname+' '+@lastname if @firstname? and @lastname?

  # Clean the password attribute and invoke id field for new user
  app.schemas.Users.pre 'save', (next) ->
    if @isNew
      if @password is undefined and @password isnt "social_auth"
        next new Error "Password field is missing"
      else if @password is "social_auth"
        @updated = new Date()
        if @id is undefined
          @id = generators.idGenerator 8
        next()
      else
        functions.hashPassword @password, (hashedPassword) =>
          @passwordHash = hashedPassword.hash
          @passwordSalt = hashedPassword.salt
          @password     = undefined
          @id           = generators.idGenerator 8
          next()
    else
      if !@id?
        @id = generators.idGenerator 8
      @updated = new Date()
      next()

  app.models.User = app.mongo.model 'User', app.schemas.Users
