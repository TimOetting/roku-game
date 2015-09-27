should = require('chai').should()
Position = require('../../src/domain/position')

describe '#position', ->
  it 'test position assigns on construct', ->
    position = new Position(2,3)
    position.x.should.equal 2
    position.y.should.equal 3