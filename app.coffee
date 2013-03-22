# My SocketStream 0.3 app
http         = require 'http'
ss           = require 'socketstream'
mongoose     = require 'mongoose'
binaryserver = require('binaryjs').BinaryServer

internals = try
	require "#{__dirname}/internals"
catch error
	console.log JSON.stringify error
	console.log error
	->

# console.log ss.api.app

# Define a single-page client called 'main'
ss.client.define 'main',
  view: 'app.jade'
  css: ['style.css', 'libs']
  code: [
    'libs/jquery.js'
  , 'libs/modernizr.js'
  , 'libs/plugins/maxmertkit.js'
  , 'libs/plugins/maxmertkit.popup.js'
  , 'libs/plugins/maxmertkit.button.js'
  , 'libs/plugins/maxmertkit.notify.js'
  , 'libs/plugins/maxmertkit.affix.js'
  , 'libs/binary.js'
  , 'app'
  ]
  tmpl: ['main', 'navigator', 'helpers']

# Serve this client on the root URL
ss.http.route '/', (req, res) ->
  res.serveClient 'main'

# Code Formatters
ss.client.formatters.add require 'ss-coffee'
ss.client.formatters.add require 'ss-jade'
ss.client.formatters.add require 'ss-stylus'

# Use server-side compiled Hogan (Mustache) templates. Others engines available
ss.client.templateEngine.use require 'ss-hogan'

# Minimize and pack assets if you type: SS_ENV=production node app.js
ss.client.packAssets() if ss.env is 'production'

# Use redis for session store
ss.session.store.use 'redis', ss.api.app.config.redis

# Use redis for pub/sub
ss.publish.transport.use 'redis', ss.api.app.config.redis

# ss.ws.transport.use require('ss-sockjs')

# Start web server
server = http.Server ss.http.middleware
server.listen 3000

bs = binaryserver
  server: server
  port: 9000

bs.on 'connection', (client) ->
  client.on 'stream', (stream, meta) ->
    write_stream = ss.api.gridStore.createWriteStream "#{ss.api.app.helpers.setters.setFilename meta.name}"
    # console.log write_stream
    # write_stream = 'something' # TODO: implement gridfs-stream
    stream.pipe(write_stream)
    stream.on 'data', (data) ->
      stream.write
        rx: data.length / meta.size
    stream.on 'end', () ->
      # console.log meta
      file = new ss.api.app.models.File
        filename: ss.api.app.helpers.setters.setFilename meta.name
        size: meta.size
        filetype: 'file'
        belong_to: meta.user
      file.save (err, saved) ->
        if err?
          console.log err
        console.log saved
        stream.write
          file:
            _id: saved._id.toString()
            id: saved.id
            filename: saved.filename
            size: saved.size
            filetype: saved.filetype

process.on 'uncaughtException', (e) ->
  console.log 'uncaughtException: ' + e

# Start SocketStream
ss.start server
