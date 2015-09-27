GameToken = require('../src/gametoken')

module.exports = class Player
  constructor: (@id, @color) ->
    @actionPoints = 6
    @gameTokens = (new GameToken(@id) for [1..6])