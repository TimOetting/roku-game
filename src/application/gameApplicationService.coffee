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

  #TODO combine sword and arrow attack to one attack method

  attack: (game, attackerTokenId, targetTokenId) ->
    attacker = game.board.gameTokens[attackerTokenId]
    target = game.board.gameTokens[targetTokenId]
    attack = @_getPossibleAttack attacker, target
    if attack?
      @_performAttack(game, attacker, attack)
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
        side.isReady = true for side in gameToken.sides
      game.gameState.activePlayer = 1 - game.gameState.activePlayer
      game.gameState.remainingPlayerTurns = 6
    game

  _containsPosition: (arr, pos) ->
    i = 0
    for item in arr
      if item.x == pos.x and item.y == pos.y
        return true
      i++
    false

  _getPossibleAttack: (attacker, target) ->
    possibleAttacks = attacker.possibleActions.swordAttacks.concat attacker.possibleActions.arrowAttacks
    for possibleAttack in possibleAttacks
      for side, sideId in attacker.sides
        if possibleAttack.targetId is target.id and possibleAttack.side is sideId and side.isReady
          return possibleAttack

