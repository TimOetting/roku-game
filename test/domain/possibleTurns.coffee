should = require('chai').should()
PossibleTurns = require('../../src/domain/possibleTurns')
Board = require('../../src/domain/board')
Position = require('../../src/domain/position')
GameToken = require('../../src/domain/gametoken')

describe '#possibleTurns', ->
  it 'test possibleTurns assigns on construct', ->
    board = new Board()
    position = new Position(1, 1)

    possibleTurns = new PossibleTurns(board, position)

    possibleTurns.board.should.equal(board)
    possibleTurns.x.should.equal(position.x)
    possibleTurns.y.should.equal(position.y)

  it 'empty position should have no possible moves', ->
    board = new Board()
    position = new Position(1, 1)

    possibleTurns = new PossibleTurns(board, position)

    possibleTurns.getMoves().should.be.empty

  it 'position with empty neighbours should have six possible moves', ->
    board = new Board()
    board.tiles[1][1] = new GameToken(1)
    position = new Position(1, 1)

    turns = new PossibleTurns(board, position).getMoves()

    turns.length.should.equal(6)
    turns[0].x.should.equal(1)
    turns[0].y.should.equal(0)

    turns[1].x.should.equal(2)
    turns[1].y.should.equal(1)

    turns[2].x.should.equal(2)
    turns[2].y.should.equal(2)

    turns[3].x.should.equal(1)
    turns[3].y.should.equal(2)

    turns[4].x.should.equal(0)
    turns[4].y.should.equal(2)

    turns[5].x.should.equal(0)
    turns[5].y.should.equal(1)