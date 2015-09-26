GameToken = require('../src/gametoken')
Point = require('../src/point')

module.exports = class Game
  constructor: (@board, player1, player2) ->
    @players = [
      player1,
      player2
    ]
    @_placeTokens()

  _placeTokens: () ->
    for y in [0..5]
      new GameToken(@players[0].id, new Point(0, y))
      new GameToken(@players[1].id, new Point(6, y))