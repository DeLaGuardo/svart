files = [
  'server/models/user.coffee'
  'server/rpc/authentication.coffee'
  'server/rpc/validate.coffee'
]

test = (cb) ->
  mocha                 = require 'mocha'
  process.env["SS_ENV"] = "test"
  ss                    = require 'socketstream'
  internals             = require "./internals"

  # console.log internals

  Mocha = new mocha
  for file in files
    Mocha.addFile "test/#{file.replace('.coffee','_test.coffee')}"
  Mocha.run (res) ->
    cb res if cb?

task 'test', 'run unit tests for the project', ->
  test process.exit
