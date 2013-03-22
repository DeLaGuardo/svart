ss = require 'socketstream'
# valid = require './server/helpers/validators'

exports.actions = (req, res, ss) ->

  req.use 'session'

  login: (data) ->
    if data.length < 6
      res status: 'failure', justification: 'Логин меньше 6 символов'
    res status: 'success'
    # Check availability of login

  password: (data) ->
    if data < 6
      res status: 'failure', justification: 'Пароль меньше 6 символов'
    res status: 'success'

  test: ->
    res status: 'failure'
