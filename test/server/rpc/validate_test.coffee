ss        = require "socketstream"
ass       = ss.start()
assert    = require "assert"
# internals = require "../../../internals"

# internals = try
#   require "../../../internals"
# catch error
#   console.log JSON.stringify error
#   console.log error
#   ->

describe 'Validate login', ->

  describe 'if login is less than 6 chars', ->

    it 'should reject this login', (done) ->
      ass.rpc 'validate.login', 'short', (result) ->
        assert.equal result[0].status, 'failure'
        done()

  describe 'if login bigger than 6 chars', ->

    it 'should accept this login', (done) ->
      ass.rpc 'validate.login', 'very long login', (result) ->
        assert.equal result[0].status, 'success'
        done()

describe 'Validate password lenght', ->

  describe 'if pasword more than 6 chars', ->

    it 'should reject this password', (done) ->
      ass.rpc 'validate.password', 7, (result) ->
        assert.equal result[0].status, 'success'
        done()

  describe 'if password less than 6 chars', ->

    it 'should accept this password', (done) ->
      ass.rpc 'validate.password', 5, (result) ->
        assert.equal result[0].status, 'failure'
        done()

  describe 'if password lenght equal 6 chars', ->

    it 'should accept this password', (done) ->
      ass.rpc 'validate.password', 6, (result) ->
        assert.equal result[0].status, 'success'
        done()
