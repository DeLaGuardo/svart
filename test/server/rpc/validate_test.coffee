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

      it 'should except this login', (done) ->
        ass.rpc 'validate.login', 'very long login', (result) ->
          assert.equal result[0].status, 'success'
          done()
