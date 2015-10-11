should = require('chai').should()
index = require('../src/index')
Game = require('../src/domain/game')
PossibleActions = require('../src/domain/possibleActions')

describe '#index', ->
  it 'create new game from applicationService', ->
    index.createNewGame().should.instanceOf(Game)

  it 'get possible turns from applicationService', ->
    game = index.createNewGame()
    index.getPossibleActions(game, 1, 1).should.instanceOf(PossibleActions)