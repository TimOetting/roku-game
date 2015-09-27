should = require('chai').should()
GameApplicationService = require('../../src/domain/gameApplicationService')
Game = require('../../src/domain/game')
gameApplicationService = new GameApplicationService();

describe '#gameApplicationService', ->
  it 'should create new game', ->
    game = gameApplicationService.createNewGame()
    game.should.instanceOf(Game)