# Internals, where the wild things are
ss = require 'socketstream'

app =
  models      : {}
  controllers : {}
  schemas     : {}
  helpers     :
    validators  : {}
    setters     : {}
    generators  : {}
    functions   : {}

app.config = require("#{__dirname}/server/config")[ss.env]

try
  require("#{__dirname}/server/helpers/functions") app.helpers.functions
  require("#{__dirname}/server/helpers/generators") app.helpers.generators
  require("#{__dirname}/server/helpers/setters") app.helpers.setters
  require("#{__dirname}/server/helpers/validators") app.helpers.validators
  require("#{__dirname}/server/redis_conf") app
  require("#{__dirname}/server/mongo") app
catch error
  console.warn error

ss.api.add 'app', app
