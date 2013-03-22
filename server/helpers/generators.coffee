#### Generators in one module ####

module.exports = (generators) ->
  generators.idGenerator = (length=8) ->
    res = ""
    res += Math.random().toString(36).substr(2).substr(0,12) while res.length < length
    res.substr 0, length
