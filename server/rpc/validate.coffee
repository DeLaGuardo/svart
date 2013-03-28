ss = require 'socketstream'

exports.actions = (req, res, ss) ->

  # req.use 'session'

  login: (data) ->
    if data.length < 6
      return res status: 'failure', justification: 'Логин меньше 6 символов'
    res status: 'success'

  password: (data) ->
    if data < 6
      return res status: 'failure', justification: 'Пароль меньше 6 символов'
    res status: 'success'

  test: ->
    res status: 'failure'
