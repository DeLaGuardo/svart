ss        = require 'socketstream'
assert    = require 'assert'
# internals = require '../../../internals'

internals = try
  require '../../../internals'
catch error
  console.log JSON.stringify error
  console.log error
  ->

User = ss.api.app.models.User

describe 'User', ->

  describe 'new', ->

    before (done) ->
      User.remove {}, (err) ->
        done()

    it 'should encrypt the password', (done) ->
      userCredentials =
        username: 'paulbjensen'
        email:    'paul@anephenix.com'
        password: '123456'

      new User(userCredentials).save (err, user) ->
        assert.equal user.password         , undefined
        assert.notEqual user.passwordHash  , undefined
        assert.notEqual user.passwordSalt  , undefined
        done()

    it 'should convert username and email', (done) ->
      userCredentials =
        username: 'paul bjenson'
        email:    'PAULBJENSEN@gmail.com'
        password: '123456'

      new User(userCredentials).save (err, user) ->
        assert.equal user.username, 'paul-bjenson'
        assert.equal user.email   , 'paulbjensen@gmail.com'
        done()

    it 'should reject all bad usernames', (done) ->
      userCredentials =
        username: 'username'
        email:    'paulbjensen@gmail.com'
        password: '123456'

      new User(userCredentials).save (err, user) ->
        assert.equal err.name, 'ValidationError'
        done()

    it 'should return fullname without hard setting this field', (done) ->
      userCredentials =
        username:  'delaguardo'
        firstname: 'Kirill'
        lastname:  'Chernyshov'
        email:     'delaguardo@gmail.com'
        password:  '1e91da30f9'

      new User(userCredentials).save (err, user) ->
        assert.equal user.fullname, 'Kirill Chernyshov'
        done()

    it 'should reject user without password', (done) ->
      userCredentials =
        username: 'delaguardo1'
        email:    'paulbjensen@gmail.com'

      new User(userCredentials).save (err, user) ->
        error = new Error 'Password field is missing'
        assert.equal err.message, error.message
        done()

    it 'should generate id for new user if user come with social auth', (done) ->
      userCredentials =
        username: 'delaguardo2'
        password: 'social_auth'
        email:    'delaguardo2@gmail.com'

      new User(userCredentials).save (err, user) ->
        assert.notEqual user.id    , undefined
        assert.equal user.password , 'social_auth'
        done()
