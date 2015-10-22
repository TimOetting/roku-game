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
    if @_containsPosition token.possibleActions.moves, position
      @_performAction(game)
      token.position = position
    return game

  swordAttack: (game, attackerTokenId, targetTokenId) ->
    attacker = game.board.gameTokens[attackerTokenId]
    target = game.board.gameTokens[targetTokenId]
    swordAttack = @_getPossibleSwordAttack attacker, target
    if swordAttack?
      @_performAttack(game, attacker, swordAttack)
    return game

  _performAttack: (game, attacker, attack) ->
    target = game.board.gameTokens[attack.targetId]
    target.health-- 
    if target.health is 0
      target.isAlive = false
    attacker.sides[attack.side].isReady = false
    @_performAction(game)
    game

  _performAction: (game) ->
    game.gameState.remainingPlayerTurns--
    if game.gameState.remainingPlayerTurns <= 0
      for gameToken in game.board.gameTokens when gameToken.playerId is game.gameState.activePlayer
        side.isReady = true for side in gameToken.side
      game.gameState.activePlayer = 1 - game.gameState.activePlayer
      game.gameState.remainingPlayerTurns = 6

  _containsPosition: (arr, pos) ->
    i = 0
    for item in arr
      if item.x == pos.x and item.y == pos.y
        return true
      i++
    false

  _getPossibleSwordAttack: (attacker, target) ->
    for possibleSwordAttack in attacker.possibleActions.swordAttacks
      for side, sideId in attacker.sides
        if possibleSwordAttack.targetId is target.id and possibleSwordAttack.side is sideId and side.isReady
          return possibleSwordAttack

