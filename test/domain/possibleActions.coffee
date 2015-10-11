should = require('chai').should()
PossibleActions = require('../../src/domain/possibleActions')

describe '#possibleActions', ->
  it 'test possibleActions assigns on construct', ->
    moves = []
    swordAttacks = []

    possibleActions = new PossibleActions(moves, swordAttacks)

    possibleActions.moves.should.equal(moves)
    possibleActions.swordAttacks.should.equal(swordAttacks)