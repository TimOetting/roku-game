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
    board = new Board()
    game = new Game(board, player1, player2)
    for gameToken in game.board.gameTokens
      gameToken.possibleActions = @getPossibleActions(game, gameToken.id)
    return game

  getPossibleActions: (game, tokenId) ->
    possibleActionsApplicationService = new PossibleActionsApplicationService(game, tokenId)
    moves = possibleActionsApplicationService.getMoves()
    swordAttacks = possibleActionsApplicationService.getSwordAttacks()
    arrowAttacks = possibleActionsApplicationService.getArrowAttacks()
    new PossibleActions(moves, swordAttacks, arrowAttacks)

  rotate: (game, tokenId, steps) ->
    token = game.board.gameTokens[tokenId]
    for i in [0...Math.abs(steps)]
      token.sides.unshift(token.sides.pop()) if steps > 0
      token.sides.push(token.sides.shift()) if steps < 0
    @_performAction(game) 
    lastAction = 
      type: 'rotate'
      steps: steps
    game.lastAction = lastAction
    game

  move: (game, tokenId, position) ->
    token = game.board.gameTokens[tokenId]
    lastAction = {}  
    if @_containsPosition token.possibleActions.moves, position
      lastAction = 
        type: 'move'
        tokenId: tokenId
        srcPos: token.position
        destPos: position
      token.position = position
      @_performAction(game)
    game.lastAction = lastAction
    game

  attack: (game, attackerTokenId, targetTokenId) ->
    attacker = game.board.gameTokens[attackerTokenId]
    target = game.board.gameTokens[targetTokenId]
    attack = @_getPossibleAttack attacker, target
    lastAction = {}
    if attack?
      target = game.board.gameTokens[attack.targetId]
      target.health-- 
      if target.health is 0
        target.isAlive = false
      attacker.sides[attack.side].isReady = false
      @_performAction(game)
      lastAction = 
        type: 'attack'
        attackerId: attackerTokenId
        targetId: targetTokenId
    game.lastAction = lastAction
    game

  _performAction: (game) ->
    game.gameState.remainingPlayerTurns--
    if game.gameState.remainingPlayerTurns <= 0
      for gameToken in game.board.gameTokens when gameToken.playerId is game.gameState.activePlayer
        side.isReady = true for side in gameToken.sides
      game.gameState.activePlayer = 1 - game.gameState.activePlayer
      game.gameState.remainingPlayerTurns = 6
    for gameToken in game.board.gameTokens
      gameToken.possibleActions = @getPossibleActions(game, gameToken.id)
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

