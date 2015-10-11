should = require('chai').should()
GameApplicationService = require('../../src/application/gameApplicationService')
Game = require('../../src/domain/game')
PossibleActions = require('../../src/domain/possibleActions')
gameApplicationService = new GameApplicationService();

describe '#gameApplicationService', ->
  it 'should create new game', ->
    game = gameApplicationService.createNewGame()
    game.should.instanceOf(Game)

  it 'should return possible moves', ->
    game = gameApplicationService.createNewGame()
    possibleActions = gameApplicationService.getPossibleActions(game, 1, 1)
    possibleActions.should.instanceOf(PossibleActions)