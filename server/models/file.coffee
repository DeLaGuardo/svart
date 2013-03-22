mongoose = require 'mongoose'

module.exports = (app) ->
  setters = app.helpers.setters
  validators = app.helpers.validators
  generators = app.helpers.generators

  app.schemas.Files = new mongoose.Schema
    id                  :
                          type: String
                          unique: yes
    filename            :
                          type: String
                          required: yes
                          unique: no
                          set: setters.setFilename
                          validate: [
                            validators.correctness('file', 'filename') ]
    size                :
                          type: Number
                          required: yes
    filetype            :
                          type: String
                          default: 'file'
                          required: yes
    belong_to           :
                          type: mongoose.Schema.ObjectId
                          ref: 'User'
    file_id             :
                          type: String
    created             :
                          type: Date
                          default: Date.now
    updated             :
                          type: Date
                          default: Date.now
    modified            :
                          type: Date
                          default: Date.now
    state_changed_at    :
                          type: Date
                          default: Date.now
    state_changed_by    :
                          type: mongoose.Schema.ObjectId
                          ref: 'User'

  app.schemas.Files.pre 'save', (next) ->
    if @isNew
      @update = new Date()
      if @id is undefined
        @id = generators.idGenerator 10
      next()
    else
      if !@id?
        @id = generators.idGenerator 10
      @updated = new Date()
      next()

  app.models.File = app.mongo.model 'File', app.schemas.Files

