should = require('chai').should()
scapegoat = require('../src/index')
hello = scapegoat.hello
attack = scapegoat.attack

describe '#hello', ->
  it 'say hello to name;', ->
    hello('roku').should.equal 'hello roku'