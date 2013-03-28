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
