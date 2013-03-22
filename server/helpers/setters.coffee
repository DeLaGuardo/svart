#### Setters module ####

module.exports = (setters) ->
  setters.setUsername = (v) -> v.replace /\ /g, '-'
  setters.setToLower = (v) -> v.toLowerCase()
  setters.setFilename = (v) -> v.replace /\ /g, '-'
