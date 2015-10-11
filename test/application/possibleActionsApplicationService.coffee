should = require('chai').should()
PossibleActionsApplicationService = require('../../src/application/possibleActionsApplicationService')
PossibleActions = require('../../src/domain/possibleActions')
Board = require('../../src/domain/board')
Position = require('../../src/domain/position')
GameToken = require('../../src/domain/gametoken')

describe '#possibleActionsApplicationService', ->
  it 'test possibleActionsApplicationService assigns on construct', ->
    board = new Board()
    position = new Position(1, 1)

    possibleActions = new PossibleActionsApplicationService(board, position)

    possibleActions.board.should.equal(board)
    possibleActions.position.x.should.equal(position.x)
    possibleActions.position.y.should.equal(position.y)

  it 'position with neighbours should have less than six possible moves', ->
    board = new Board()
    board.gameTokens.push(new GameToken(1))
    board.gameTokens.push(new GameToken(1))
    board.gameTokens[0].position = new Position(1,1)
    board.gameTokens[1].position = new Position(2,1)

    position = new Position(1, 1)

    turns = new PossibleActionsApplicationService(board, position).getMoves()

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
    board.gameTokens[0].position = new Position(1, 1)
    board.gameTokens[1].position = new Position(2, 1)

    position = new Position(1, 1)

    turns = new PossibleActionsApplicationService(board, position).getSwordAttacks()

    turns.length.should.equal(1)

  it 'test getArrowAttacks', ->
    board = new Board()

    board.gameTokens.push(new GameToken(1))
    board.gameTokens.push(new GameToken(2))
    board.gameTokens[0].position = new Position(1, 1)
    board.gameTokens[1].position = new Position(3, 0)

    position = new Position(1, 1)

    turns = new PossibleActionsApplicationService(board, position).getArrowAttacks()

    turns.length.should.equal(0)