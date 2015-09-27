GameToken = require('./gametoken')

module.exports = class Player
  constructor: (@id) ->
    @actionPoints = 6
    @gameTokens = (new GameToken(@id) for [1..6])