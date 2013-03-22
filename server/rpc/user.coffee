ss_server = require 'socketstream'
async = require 'async'

# User = ss.api.app.models.User
functions = ss_server.api.app.helpers.functions
# File = ss.api.app.models.File

exports.actions = (req, res, ss) ->
  req.use 'session'

  save_file: (data) ->
    getUser = (callback) ->
      functions.fetchUserFromSession req, res, (user) ->
        if !user?
          return callback -1
        callback null, user
    updateUser = (user, callback) ->
      user.files.push data._id
      callback null, user
    async.waterfall [
      getUser
      updateUser
      functions.saveUser
      ], (err, result) ->
      if err?
        return res status: 'failure', reason: 'Cant save file to user'
      res status: 'success'

  get_files: ->
    getUser = (callback) ->
      functions.fetchUserFromSession req, res, (user) ->
        if !user?
          return callback -1
        callback null, user.files
    getFiles = (files_id, callback) ->
      ss_server.api.app.models.File.find().where('_id').in(files_id).exec (err, files) ->
        callback null, files
    async.waterfall [
      getUser
      getFiles
      ], (err, files) ->
      if err?
        return res status: 'failure', reason: 'Cant find all files'
      res status: 'success', files: files
