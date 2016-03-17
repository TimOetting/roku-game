should = require('chai').should()
GameApplicationService = require('../../src/application/gameApplicationService')
Game = require('../../src/domain/game')
Weapon = require('../../src/domain/weapon')
Position = require('../../src/domain/position')
PossibleActions = require('../../src/domain/possibleActions')
gameApplicationService = new GameApplicationService();

describe '#gameApplicationService', ->
  game = gameApplicationService.createNewGame()
  # before (done) ->
  #   done()
  it 'should create new game', ->
    game.should.instanceOf(Game)

  it 'should return possible actions', ->
    possibleActions = gameApplicationService.getPossibleActions(game, 0)
    possibleActions.should.instanceOf(PossibleActions)

  it 'should perform rotation', ->
    game.board.gameTokens[0].sides = [
        {isReady: true, weapon: Weapon.shield}
        {isReady: true, weapon: Weapon.sword}
        {isReady: true, weapon: Weapon.arrow}
        {isReady: true, weapon: Weapon.shield}
        {isReady: true, weapon: Weapon.sword}
        {isReady: true, weapon: Weapon.arrow}
      ]
    gameApplicationService.rotate game, 0, -1
    game.board.gameTokens[0].sides.should.be.eql [
        {isReady: true, weapon: Weapon.sword}
        {isReady: true, weapon: Weapon.arrow}
        {isReady: true, weapon: Weapon.shield}
        {isReady: true, weapon: Weapon.sword}
        {isReady: true, weapon: Weapon.arrow}
        {isReady: true, weapon: Weapon.shield}
      ]
    gameApplicationService.rotate game, 0, 2
    game.board.gameTokens[0].sides.should.be.eql [
        {isReady: true, weapon: Weapon.arrow}
        {isReady: true, weapon: Weapon.shield}
        {isReady: true, weapon: Weapon.sword}
        {isReady: true, weapon: Weapon.arrow}
        {isReady: true, weapon: Weapon.shield}
        {isReady: true, weapon: Weapon.sword}
      ]
    gameApplicationService.rotate game, 0, -1
    game.board.gameTokens[0].sides.should.be.eql [
        {isReady: true, weapon: Weapon.shield}
        {isReady: true, weapon: Weapon.sword}
        {isReady: true, weapon: Weapon.arrow}
        {isReady: true, weapon: Weapon.shield}
        {isReady: true, weapon: Weapon.sword}
        {isReady: true, weapon: Weapon.arrow}
      ]

  it 'should perform token move if it is a possible action', ->
    game = gameApplicationService.createNewGame()
    game.board.gameTokens[0].possibleActions.moves = [new Position(1, 0)]
    game = gameApplicationService.move game, 0, new Position(1, 0)
    game.board.gameTokens[0].position.should.be.eql new Position(1, 0)

  it 'should not perform token move if it is not a possible action', ->
    game = gameApplicationService.createNewGame()
    game.board.gameTokens[0].possibleActions.moves = []
    oldPosition = game.board.gameTokens[0].position
    game = gameApplicationService.move game, 0, new Position(1, 0)
    game.board.gameTokens[0].position.should.be.equal oldPosition

  it 'should perform attack if it is a possible action', ->
    game = gameApplicationService.createNewGame()
    game.board.gameTokens[0].position = new Position 0, 1 

    game.board.gameTokens[0].possibleActions.swordAttacks = [
        side: 1
        targetId: 6
      ]  
    game.board.gameTokens[6].position = new Position 1, 1 
    game = gameApplicationService.attack game, 0, 6
    game.board.gameTokens[6].health.should.be.equal 9

    game.board.gameTokens[0].possibleActions.arrowAttacks = [
        side: 2
        targetId: 7
      ]
    game.board.gameTokens[7].position = new Position 2, 2 
    game = gameApplicationService.attack game, 0, 7
    game.board.gameTokens[7].health.should.be.equal 9

  it 'should not be able to perform attack twice in the same turn', ->
    game = gameApplicationService.createNewGame()
    game.board.gameTokens[0].position = new Position 0, 1 

    game.board.gameTokens[0].possibleActions.swordAttacks = [
        side: 1
        targetId: 6
      ]  
    game.board.gameTokens[0].possibleActions.arrowAttacks = []  
    game.board.gameTokens[6].position = new Position 1, 1 

    game = gameApplicationService.attack game, 0, 6
    game.board.gameTokens[0].possibleActions.arrowAttacks = []  
    game = gameApplicationService.attack game, 0, 6
    game.board.gameTokens[6].health.should.be.equal 9
    game.board.gameTokens[0].possibleActions.arrowAttacks = [
        side: 2
        targetId: 7
      ]
    game.board.gameTokens[7].position = new Position 2, 2 
    game = gameApplicationService.attack game, 0, 7
    game = gameApplicationService.attack game, 0, 7
    game.board.gameTokens[7].health.should.be.equal 9

  it 'should not perform attack if it is not a possible action', ->
    game = gameApplicationService.createNewGame()
    game.board.gameTokens[0].position = new Position 0, 1 

    game.board.gameTokens[0].possibleActions.swordAttacks = [
        side: 1
        targetId: 8
      ]  
    game.board.gameTokens[0].possibleActions.arrowAttacks = [
        side: 2
        targetId: 9
      ]

    game.board.gameTokens[6].position = new Position 1, 1 
    game = gameApplicationService.attack game, 0, 6
    game.board.gameTokens[6].health.should.be.equal 10

    game.board.gameTokens[7].position = new Position 2, 2 
    game = gameApplicationService.attack game, 0, 7
    game.board.gameTokens[7].health.should.be.equal 10

  it 'should switch active player after 6 actions', ->
    game = gameApplicationService.createNewGame()
    game = gameApplicationService._performAction game
    game = gameApplicationService._performAction game
    game = gameApplicationService._performAction game
    game = gameApplicationService._performAction game
    game = gameApplicationService._performAction game
    game.gameState.activePlayer.should.be.equal 0
    game = gameApplicationService._performAction game
    game.gameState.activePlayer.should.be.equal 1