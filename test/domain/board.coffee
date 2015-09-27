should = require('chai').should()
Board = require('../../src/domain/board')

describe '#board', ->
  it 'test board assigns on construct', ->
    board = new Board()
    board.gameTokens.length.should.be.empty