Game = require('./game')
Player = require('./player')
Board = require('./board')
PossibleTurns = require('./possibleTurns')
Position = require('./position')

module.exports = class GameApplicationService

  createNewGame: () ->
    player1 = new Player(1)
    player2 = new Player(2)
    board = new Board();

    new Game(board, player1, player2)

  getPossibleActions: (game, x ,y) ->
    position = new Position(x,y)
    new PossibleTurns(game.board, position)