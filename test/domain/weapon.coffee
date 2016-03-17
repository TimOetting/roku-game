should = require('chai').should()
Weapon = require('../../src/domain/weapon')

describe '#weapon', ->
  it 'test Weapon enums', ->
    Weapon.none.should.equal 0
    Weapon.shield.should.equal 1
    Weapon.sword.should.equal 2
    Weapon.arrow.should.equal 3