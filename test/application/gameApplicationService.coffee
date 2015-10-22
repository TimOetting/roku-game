should = require('chai').should()
GameApplicationService = require('../../src/application/gameApplicationService')
Game = require('../../src/domain/game')
Position = require('../../src/domain/position')
PossibleActions = require('../../src/domain/possibleActions')
gameApplicationService = new GameApplicationService();

describe '#gameApplicationService', ->
  it 'should create new game', ->
    game = gameApplicationService.createNewGame()
    game.should.instanceOf(Game)

  it 'should return possible actions', ->
    game = gameApplicationService.createNewGame()
    possibleActions = gameApplicationService.getPossibleActions(game, 0)
    possibleActions.should.instanceOf(PossibleActions)

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