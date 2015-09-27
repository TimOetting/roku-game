Position = require('./position')

module.exports = class Game
  constructor: (@board, player1, player2) ->
    @players = [
      player1,
      player2
    ]
    @_placeTokens()

  _placeTokens: () ->
    for player, i in @players
      for gameToken, j in player.gameTokens
        if i == 0
          gameToken.position = new Position(j,0)
        else
          gameToken.position = new Position(j,5)
        @board.gameTokens.push gameToken