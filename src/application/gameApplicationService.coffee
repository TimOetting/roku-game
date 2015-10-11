Game = require('../domain/game')
Player = require('../domain/player')
Board = require('../domain/board')
PossibleTurns = require('../domain/possibleTurns')
Position = require('../domain/position')
PossibleTurnsApplicationService = require('./possibleTurnsApplicationService')

module.exports = class GameApplicationService

  createNewGame: () ->
    player1 = new Player(1)
    player2 = new Player(2)
    board = new Board();

    new Game(board, player1, player2)

  getPossibleActions: (game, x ,y) ->
    position = new Position(x,y)
    possibleTurnsApplicationService = new PossibleTurnsApplicationService(game.board, position)
    moves = possibleTurnsApplicationService.getMoves()
    swordAttacks = possibleTurnsApplicationService.getSwordAttacks()

    new PossibleTurns(moves, swordAttacks)