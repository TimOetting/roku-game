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
    for gameToken in game.board.gameTokens
      gameToken.possibleActions = @getPossibleActions(game, gameToken.id)
    return game

  getPossibleActions: (game, tokenId) ->
    possibleActionsApplicationService = new PossibleActionsApplicationService(game, tokenId)
    moves = possibleActionsApplicationService.getMoves()
    swordAttacks = possibleActionsApplicationService.getSwordAttacks()
    arrowAttacks = possibleActionsApplicationService.getSwordAttacks()
    new PossibleActions(moves, swordAttacks, arrowAttacks)

  move: (game, tokenId, position) ->
    token = game.board.gameTokens[tokenId]
    console.log new Position(1,0) in token.possibleActions.moves
    if containsPosition token.possibleActions.moves, position
      token.position = position
    return game

containsPosition = (arr, pos) ->
  i = 0
  for item in arr
    if item.x == pos.x and item.y == pos.y
      return true
    i++
  false