should = require('chai').should()
GameToken = require('../src/gametoken')
Weapon = require('../src/weapon')

describe '#gameToken', ->
  it 'test GameToken assigns on construct', ->
    gameToken = new GameToken(42)

    gameToken.playerId.should.equal 42
    gameToken.health.should.equal 10
    gameToken.sides.length.should.equal 6
    gameToken.sides[0].should.equal Weapon.shield
    gameToken.sides[1].should.equal Weapon.sword
    gameToken.sides[2].should.equal Weapon.arrow
    gameToken.sides[3].should.equal Weapon.shield
    gameToken.sides[4].should.equal Weapon.sword
    gameToken.sides[5].should.equal Weapon.arrow