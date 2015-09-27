should = require('chai').should()
index = require('../src/index')
Game = require('../src/domain/game')

describe '#index', ->
  it 'create new game from applicationService', ->
    index.createNewGame().should.instanceOf(Game)