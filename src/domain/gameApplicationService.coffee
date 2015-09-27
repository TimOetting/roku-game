Game = require('./game')
Player = require('./player')
Board = require('./board')

module.exports = class GameApplicationService

  createNewGame: () ->
    player1 = new Player(1)
    player2 = new Player(2)
    board = new Board();

    new Game(board, player1, player2)