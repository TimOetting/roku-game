should = require('chai').should()
GameToken = require('../../src/domain/gametoken')
Weapon = require('../../src/domain/weapon')

describe '#gameToken', ->
  it 'test GameToken assigns on construct', ->
    gameToken = new GameToken(42)

    gameToken.playerId.should.equal 42
    gameToken.health.should.equal 10
    gameToken.sides.length.should.equal 6

    gameToken.sides[0].weapon.should.equal Weapon.shield
    gameToken.sides[1].weapon.should.equal Weapon.sword
    gameToken.sides[2].weapon.should.equal Weapon.arrow
    # gameToken.sides[3].weapon.should.equal null
    (gameToken.sides[3].weapon == null).should.be.true
    gameToken.sides[4].weapon.should.equal Weapon.sword
    gameToken.sides[5].weapon.should.equal Weapon.arrow

    gameToken.sides[0].isReady.should.equal true
    gameToken.sides[1].isReady.should.equal true
    gameToken.sides[2].isReady.should.equal true
    gameToken.sides[3].isReady.should.equal true
    gameToken.sides[4].isReady.should.equal true
    gameToken.sides[5].isReady.should.equal true