should = require('chai').should()
Player = require('../../src/domain/player')

describe '#player', ->
  it 'test player assigns on construct', ->
    player = new Player(42)
    player.id.should.equal 42
    player.actionPoints.should.equal 6
    player.gameTokens.length.should.equal 6
    player.gameTokens[0].health.should.equal 10
    player.gameTokens[1].health.should.equal 10
    player.gameTokens[2].health.should.equal 10
    player.gameTokens[3].health.should.equal 10
    player.gameTokens[4].health.should.equal 10
    player.gameTokens[5].health.should.equal 10