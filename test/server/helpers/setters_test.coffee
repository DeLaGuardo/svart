ss        = require 'socketstream'
assert    = require 'assert'

describe 'Setters', ->

  it 'should replace spaces with \'-\'', (done) ->
    assert.equal 'my-username', ss.api.app.helpers.setters.setUsername 'my username'
    assert.equal 'my-filename', ss.api.app.helpers.setters.setFilename 'my filename'
    done()

  it 'should set string to Lower Case format', (done) ->
    assert.equal 'lower case', ss.api.app.helpers.setters.setToLower 'LOWER Case'
    done()
