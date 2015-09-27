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
    possibleTurns.position.x.should.equal(position.x)
    possibleTurns.position.y.should.equal(position.y)

  it 'position with neighbours should have less than six possible moves', ->
    board = new Board()
    board.gameTokens.push(new GameToken(1))
    board.gameTokens.push(new GameToken(1))
    board.gameTokens[0].position = new Position(1,1)
    board.gameTokens[1].position = new Position(2,1)

    position = new Position(1, 1)

    turns = new PossibleTurns(board, position).getMoves()

    turns.length.should.equal(5)
    #turns[0].x.should.equal(1)
    #turns[0].y.should.equal(0)
    #turns[1].x.should.equal(2)
    #turns[1].y.should.equal(1)
    #turns[2].x.should.equal(2)
    #turns[2].y.should.equal(2)
    #turns[3].x.should.equal(1)
    #turns[3].y.should.equal(2)
    #turns[4].x.should.equal(0)
    #turns[4].y.should.equal(2)
    #turns[5].x.should.equal(0)
    #turns[5].y.should.equal(1)


  it 'test getSwordAttacks', ->
    board = new Board()

    board.gameTokens.push(new GameToken(1))
    board.gameTokens.push(new GameToken(2))
    board.gameTokens[0].position = new Position(1,1)
    board.gameTokens[1].position = new Position(2,1)

    position = new Position(1, 1)

    turns = new PossibleTurns(board, position).getSwordAttacks()

    turns.length.should.equal(0)
