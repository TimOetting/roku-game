should = require('chai').should()
Game = require('../../src/domain/game')
Player = require('../../src/domain/player')
Board = require('../../src/domain/board')

describe '#game', ->
  it 'test game assigns on construct', ->
    player1 = new Player(1, "#ff0000")
    player2 = new Player(1, "#00ff00")
    board = new Board();
    game = new Game(board, player1, player2)
    game.players.length.should.equal 2

  it 'should place tokens on board', ->
    player1 = new Player(1, "#ff0000")
    player2 = new Player(1, "#00ff00")
    board = new Board();
    game = new Game(board, player1, player2)

    game.board.gameTokens[0].position.x.should.equal(0)
    game.board.gameTokens[0].position.y.should.equal(0)
    game.board.gameTokens[1].position.x.should.equal(1)
    game.board.gameTokens[1].position.y.should.equal(0)
    game.board.gameTokens[2].position.x.should.equal(2)
    game.board.gameTokens[2].position.y.should.equal(0)
    game.board.gameTokens[3].position.x.should.equal(3)
    game.board.gameTokens[3].position.y.should.equal(0)
    game.board.gameTokens[4].position.x.should.equal(4)
    game.board.gameTokens[4].position.y.should.equal(0)
    game.board.gameTokens[5].position.x.should.equal(5)
    game.board.gameTokens[5].position.y.should.equal(0)

    game.board.gameTokens[6].position.x.should.equal(0)
    game.board.gameTokens[6].position.y.should.equal(5)
    game.board.gameTokens[7].position.x.should.equal(1)
    game.board.gameTokens[7].position.y.should.equal(5)
    game.board.gameTokens[8].position.x.should.equal(2)
    game.board.gameTokens[8].position.y.should.equal(5)
    game.board.gameTokens[9].position.x.should.equal(3)
    game.board.gameTokens[9].position.y.should.equal(5)
    game.board.gameTokens[10].position.x.should.equal(4)
    game.board.gameTokens[10].position.y.should.equal(5)
    game.board.gameTokens[11].position.x.should.equal(5)
    game.board.gameTokens[11].position.y.should.equal(5)

