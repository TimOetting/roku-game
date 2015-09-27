should = require('chai').should()
GameApplicationService = require('../../src/domain/gameApplicationService')
Game = require('../../src/domain/game')
PossibleTurns = require('../../src/domain/possibleTurns')
gameApplicationService = new GameApplicationService();

describe '#gameApplicationService', ->
  it 'should create new game', ->
    game = gameApplicationService.createNewGame()
    game.should.instanceOf(Game)

  it 'should return possible moves', ->
    game = gameApplicationService.createNewGame()
    possibleTurns = gameApplicationService.getPossibleActions(game, 1, 1)
    possibleTurns.should.instanceOf(PossibleTurns)