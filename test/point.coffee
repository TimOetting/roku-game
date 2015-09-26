should = require('chai').should()
Point = require('../src/point')

describe '#point', ->
  it 'test point assigns on construct', ->
    point = new Point(2,3)
    point.x.should.equal 2
    point.y.should.equal 3