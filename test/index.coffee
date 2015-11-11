should = require('chai').should()
index = require('../src/index')
Game = require('../src/domain/game')
Weapon = require('../src/domain/weapon')
Position = require('../src/domain/position')
PossibleActions = require('../src/domain/possibleActions')
GameApplicationService = require('../src/application/gameApplicationService')
gameApplicationService = new GameApplicationService()

describe '#index', ->
  it 'create new game from applicationService', ->
    index.createNewGame().should.instanceOf(Game)

  it 'get possible turns from applicationService', ->
    game = index.createNewGame()
    index.getPossibleActions(game, 0).should.instanceOf(PossibleActions)

  it 'perform rotation', ->
    game = index.createNewGame()
    game.board.gameTokens[0].sides = [
        {isReady: true, weapon: Weapon.shield}
        {isReady: true, weapon: Weapon.sword}
        {isReady: true, weapon: Weapon.arrow}
        {isReady: true, weapon: Weapon.shield}
        {isReady: true, weapon: Weapon.sword}
        {isReady: true, weapon: Weapon.arrow}
      ]
    console.log game.board.gameTokens[0].sides
    index.rotate(game, 0, 1)
    console.log game.board.gameTokens[0].sides
    game.board.gameTokens[0].sides.should.be.eql [
        {isReady: true, weapon: Weapon.arrow}
        {isReady: true, weapon: Weapon.shield}
        {isReady: true, weapon: Weapon.sword}
        {isReady: true, weapon: Weapon.arrow}
        {isReady: true, weapon: Weapon.shield}
        {isReady: true, weapon: Weapon.sword}
      ]

  it 'perform move', ->
    game = index.createNewGame()
    index.move(game, 0, new Position(1,0))
    game.board.gameTokens[0].position.should.eql {x: 1, y: 0}

  it 'perform attack', ->
    game = index.createNewGame()
    game.board.gameTokens[0].possibleActions.swordAttacks = [
        side: 1
        targetId: 6
      ]  
    game.board.gameTokens[6].position = new Position 1, 1 
    game = gameApplicationService.attack game, 0, 6
    game.board.gameTokens[6].health.should.be.equal 9