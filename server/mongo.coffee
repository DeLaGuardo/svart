mongoose = require 'mongoose'
ss = require 'socketstream'
gridfs = require 'gridfs-stream'
gridfs.mongo = mongoose.mongo

module.exports = (app) ->
  mongo_conf = app.config.mongo
  store_conf = app.config.store
  mongo_uri = "mongodb://#{mongo_conf.host || 'localhost'}:#{mongo_conf.port || 27017}/#{mongo_conf.db || 'default_database'}"
  store_uri = "mongodb://#{store_conf.host || 'localhost'}:#{store_conf.port || 27017}/#{store_conf.db || 'default_database'}"
  app.mongo = mongoose.createConnection(mongo_uri)
  app.store = mongoose.createConnection(store_uri)

  require("#{__dirname}/models/user.coffee") app
  require("#{__dirname}/models/file.coffee") app

  # console.log app

  app.store.once 'open', () ->
    grid = gridfs app.store.db
    ss.api.add 'gridStore', grid
    console.log ss.api.gridStore
