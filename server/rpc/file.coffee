async     = require 'async'
sss       = require 'socketstream'

User      = sss.api.app.models.User
Redis     = sss.api.app.redis
config    = sss.api.app.config
functions = sss.api.app.helpers.functions

exports.actions = (req, res, ss) ->
  req.use 'session'

  getFiles: () ->
    # console.log Store
    sss.api.gridStore.files.find().toArray (err, files) ->
      if err?
        console.log err
      res status: 'success', files: files
