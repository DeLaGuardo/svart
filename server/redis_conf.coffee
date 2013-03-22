redis = require 'redis'
ss = require 'socketstream'

module.exports = (app) ->
  app.redis = redis.createClient app.config.redis.port, app.config.redis.host
  app.redis.auth app.config.redis.password if ss.env is 'production'
