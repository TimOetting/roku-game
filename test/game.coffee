should = require('chai').should()
Game = require('../src/game')
Player = require('../src/player')
Board = require('../src/board')

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

    game.board.tiles[0][0].should.equal(player1.gameTokens[0])
    game.board.tiles[0][1].should.equal(player1.gameTokens[1])
    game.board.tiles[0][2].should.equal(player1.gameTokens[2])
    game.board.tiles[0][3].should.equal(player1.gameTokens[3])
    game.board.tiles[0][4].should.equal(player1.gameTokens[4])
    game.board.tiles[0][5].should.equal(player1.gameTokens[5])

    game.board.tiles[5][0].should.equal(player2.gameTokens[0])
    game.board.tiles[5][1].should.equal(player2.gameTokens[1])
    game.board.tiles[5][2].should.equal(player2.gameTokens[2])
    game.board.tiles[5][3].should.equal(player2.gameTokens[3])
    game.board.tiles[5][4].should.equal(player2.gameTokens[4])
    game.board.tiles[5][5].should.equal(player2.gameTokens[5])