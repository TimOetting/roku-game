Game = require('../domain/game')
Player = require('../domain/player')
Board = require('../domain/board')
PossibleActions = require('../domain/possibleActions')
Position = require('../domain/position')
PossibleActionsApplicationService = require('./possibleActionsApplicationService')

module.exports = class GameApplicationService

  createNewGame: () ->
    player1 = new Player(1)
    player2 = new Player(2)
    board = new Board();
    game = new Game(board, player1, player2)

  getPossibleActions: (game, tokenId) ->
    possibleActionsApplicationService = new PossibleActionsApplicationService(game, tokenId)
    moves = possibleActionsApplicationService.getMoves()
    swordAttacks = possibleActionsApplicationService.getSwordAttacks()

    new PossibleActions(moves, swordAttacks)