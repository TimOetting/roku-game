should = require('chai').should()
Player = require('../src/player')

describe '#player', ->
  it 'test player assigns on construct', ->
    player = new Player(42,"#ffff00")
    player.id.should.equal 42
    player.color.should.equal "#ffff00"
    player.actionPoints.should.equal 6