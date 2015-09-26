var should = require('chai').should(),
    scapegoat = require('../index'),
    hello = scapegoat.hello;

describe('#hello', function() {
  it('say hello to name;', function() {
    hello('roku').should.equal('hello roku');
  });
});