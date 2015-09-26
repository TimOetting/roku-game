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

  it 'should place tokens on board - todo move token creation to player'