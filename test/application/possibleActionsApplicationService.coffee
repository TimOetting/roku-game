should = require('chai').should()
PossibleActionsApplicationService = require('../../src/application/possibleActionsApplicationService')
PossibleActions = require('../../src/domain/possibleActions')
Board = require('../../src/domain/board')
Game = require('../../src/domain/game')
Player = require('../../src/domain/player')
Position = require('../../src/domain/position')
GameToken = require('../../src/domain/gametoken')

describe '#possibleActionsApplicationService', ->
  it 'test possibleActionsApplicationService assigns on construct', ->
    game = getTestGameSetup()
    # position = new Position(1, 1)

    possibleActions = new PossibleActionsApplicationService(game, 0)

    possibleActions.game.should.equal(game)
    # possibleActions.position.x.should.equal(position.x)
    # possibleActions.position.y.should.equal(position.y)

  it 'position with neighbours should have less than six possible moves', ->
    game = getTestGameSetup()

    # game.board.gameTokens.push(new GameToken(1))
    # game.board.gameTokens.push(new GameToken(1))
    # game.board.gameTokens[0].position = new Position(1,1)
    # game.board.gameTokens[1].position = new Position(2,1)

    # position = new Position(0, 0)

    turns = new PossibleActionsApplicationService(game, 0).getMoves()

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


  # it 'test getPossibleActions', ->
  #   board = new Board()

  #   board.gameTokens.push(new GameToken(1))
  #   board.gameTokens.push(new GameToken(2))
  #   board.gameTokens[0].position = new Position(1, 1)
  #   board.gameTokens[1].position = new Position(2, 1)

  #   position = new Position(1, 1)

  #   actions = new PossibleActionsApplicationService(board, position).getSwordAttacks()

  #   turns.length.should.equal(1)

  it 'test getSwordAttacks', ->
    game = getTestGameSetup()

    # game.board.gameTokens.push(new GameToken(1))
    # game.board.gameTokens.push(new GameToken(2))
    game.board.gameTokens[0].position = new Position(1, 1)
    game.board.gameTokens[6].position = new Position(2, 1)

    # position = new Position(1, 1)

    turns = new PossibleActionsApplicationService(game, 0).getSwordAttacks()

    turns.length.should.equal(1)

  it 'test getArrowAttacks', ->
    game = getTestGameSetup()

    # game.board.gameTokens.push(new GameToken(1))
    # game.board.gameTokens.push(new GameToken(2))
    game.board.gameTokens[0].position = new Position(1, 1)
    game.board.gameTokens[6].position = new Position(3, 1)

    # position = new Position(1, 1)

    turns = new PossibleActionsApplicationService(game, 0).getArrowAttacks()

    turns.length.should.equal(1)

getTestGameSetup = () ->
  player1 = new Player(0, "#ff0000")
  player2 = new Player(1, "#00ff00")
  board = new Board();
  game = new Game(board, player1, player2)
