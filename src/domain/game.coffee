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
          @board.tiles[0][j] = gameToken
        else
          @board.tiles[5][j] = gameToken