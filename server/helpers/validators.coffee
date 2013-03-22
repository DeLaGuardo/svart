_ = require 'lodash/dist/lodash.underscore'

validEmailRegExp = /^[-a-z0-9!#$%&'*+/=?^_`{|}~]+(?:\.[-a-z0-9!#$%&'*+/=?^_`{|}~]+)*@(?:[a-z0-9]([-a-z0-9]{0,61}[a-z0-9])?\.)*(?:aero|arpa|asia|biz|cat|com|coop|edu|gov|info|int|jobs|mil|mobi|museum|name|net|org|pro|tel|travel|[a-z][a-z])$/
validUsernameRegExp = /^[A-Za-z0-9][A-Za-z0-9\ \-_\.]+[A-Za-z0-9]$/
validFilenameRegExp = /^[A-Za-z0-9][A-Za-z0-9\ \-_\.]+[A-Za-z0-9]$/
badUserNames = [
  '404'
, 'file'
, 'username'
, 'admin'
]

length_limits =
  user:
    username  : 100
    lastname  : 100
    firstname : 100
    login     : 30
    email     : 60

field_correctness =
  user:
    username : (v) -> (validUsernameRegExp.test v) and !(v in badUserNames)
    email    : (v) -> validEmailRegExp.test v
  file:
    filename : (v) -> validFilenameRegExp.test v

module.exports = (helpers) ->

  helpers.length_less = (type, field) ->
    res =
      validator: (v) -> !v? or (v.length < length_limits[type][field])
      msg: 'long'

  helpers.not_empty = () ->
    res =
      validator: (v) -> v.length > 0
      msg: 'empty'

  helpers.exists = () ->
    res =
      validator: (v) -> v?
      msg: 'exist'

  helpers.correctness = (type, field) ->
    res =
      validator: field_correctness[type][field]
      msg: 'correct'
