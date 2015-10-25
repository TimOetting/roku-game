Position = require('./position')

module.exports = class Game
  constructor: (@board, player1, player2) ->
    @players = [
      player1,
      player2
    ]
    @createdAt = new Date
    @gameState = 
      activePlayer: 0
      remainingPlayerTurns: 6
    @_placeTokens()

  _placeTokens: () ->
    for player, i in @players
      for gameToken, j in player.gameTokens
        gameToken.id = (i * (player.gameTokens.length)) + j
        gameToken.playerId = i
        if i == 0
          gameToken.position = new Position(0,j)
        else
          gameToken.position = new Position(5,j)
        @board.gameTokens.push gameToken