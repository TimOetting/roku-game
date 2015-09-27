should = require('chai').should()
PossibleTurns = require('../../src/domain/possibleTurns')
Board = require('../../src/domain/board')
Position = require('../../src/domain/position')

describe '#possibleTurns', ->
  it 'test possibleTurns assigns on construct', ->
    board = new Board()
    position = new Position(1, 1)

    possibleTurns = new PossibleTurns(board, position)

    possibleTurns.board.should.equal(board)
    possibleTurns.position.should.equal(position)