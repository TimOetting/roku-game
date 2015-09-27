module.exports = class Game
  constructor: (@board, player1, player2) ->
    @players = [
      player1,
      player2
    ]
    @_placeTokens()

  _placeTokens: () ->
    return