should = require('chai').should()
Weapon = require('../../src/domain/weapon')

describe '#weapon', ->
  it 'test Weapon enums', ->
    Weapon.shield.should.equal 0
    Weapon.sword.should.equal 1
    Weapon.arrow.should.equal 2