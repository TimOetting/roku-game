should = require('chai').should()
PossibleTurns = require('../../src/domain/possibleTurns')

describe '#possibleTurns', ->
  it 'test possibleTurns assigns on construct', ->
    moves = []
    swordAttacks = []

    possibleTurns = new PossibleTurns(moves, swordAttacks)

    possibleTurns.moves.should.equal(moves)
    possibleTurns.swordAttacks.should.equal(swordAttacks)