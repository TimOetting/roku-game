should = require('chai').should()
Board = require('../src/board')

describe '#board', ->
  it 'test board assigns on construct', ->
    board = new Board()
    board.tiles.length.should.equal 7
    board.tiles[0].length.should.equal 6