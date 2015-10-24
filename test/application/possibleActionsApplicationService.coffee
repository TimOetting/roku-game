should = require('chai').should()
PossibleActionsApplicationService = require('../../src/application/possibleActionsApplicationService')
PossibleActions = require('../../src/domain/possibleActions')
Board = require('../../src/domain/board')
Game = require('../../src/domain/game')
Player = require('../../src/domain/player')
Position = require('../../src/domain/position')
GameToken = require('../../src/domain/gametoken')
Weapon = require('../../src/domain/weapon')

describe '#possibleActionsApplicationService', ->
  it 'test possibleActionsApplicationService assigns on construct', ->
    game = getTestGameSetup()

    possibleActions = new PossibleActionsApplicationService(game, 0)

    possibleActions.game.should.equal(game)
    # possibleActions.position.x.should.equal(position.x)
    # possibleActions.position.y.should.equal(position.y)

  it 'position with neighbours should have less than six possible moves', ->
    game = getTestGameSetup()

    turns = new PossibleActionsApplicationService(game, 0).getMoves()

    turns.length.should.equal(5)
    #turns[0].x.should.equal(1)
    #turns[0].y.should.equal(0)
    #turns[1].x.should.equal(2)
    #turns[1].y.should.equal(1)
    #turns[2].x.should.equal(2)
    #turns[2].y.should.equal(2)
    #turns[3].x.should.equal(1)
    #turns[3].y.should.equal(2)
    #turns[4].x.should.equal(0)
    #turns[4].y.should.equal(2)
    #turns[5].x.should.equal(0)
    #turns[5].y.should.equal(1)

  it 'test getSwordAttacks', ->
    game = getTestGameSetup()
    game.board.gameTokens[0].position = new Position(1, 1)
    game.board.gameTokens[6].position = new Position(2, 1)
    possibleSwordAttacks = new PossibleActionsApplicationService(game, 0).getSwordAttacks()

    possibleSwordAttacks.length.should.equal(1)

  it 'test getArrowAttacks', ->
    game = getTestGameSetup()
    game.board.gameTokens[0].position = new Position(2, 2)
    for side in game.board.gameTokens[0].sides
      side.weapon = Weapon.arrow
    game.board.gameTokens[1].position = new Position(1, 1)
    game.board.gameTokens[3].position = new Position(1, 2)
    game.board.gameTokens[6].position = new Position(5, 0)
    game.board.gameTokens[7].position = new Position(2, 0)
    game.board.gameTokens[7].sides[3].weapon = Weapon.sword
    game.board.gameTokens[8].position = new Position(2, 8)
    game.board.gameTokens[8].sides[0].weapon = Weapon.sword
    game.board.gameTokens[9].position = new Position(5, 3)
    game.board.gameTokens[10].position = new Position(0, 3)
    game.board.gameTokens[11].position = new Position(0, 1)
    possibleArrowAttacks = new PossibleActionsApplicationService(game, 0).getArrowAttacks()
    possibleArrowAttacks.length.should.equal(6)
    game.board.gameTokens[8].position = new Position(2, 9)
    possibleArrowAttacks = new PossibleActionsApplicationService(game, 0).getArrowAttacks()
    # Test too large distance
    possibleArrowAttacks.length.should.equal(5)
    # Test blocked attacks
    for token in game.board.gameTokens
      for side in token.sides
        side.weapon = Weapon.shield
    for side in game.board.gameTokens[0].sides
      side.weapon = Weapon.arrow
    possibleArrowAttacks = new PossibleActionsApplicationService(game, 0).getArrowAttacks()
    possibleArrowAttacks.length.should.equal(0)

  it 'test _getDistantNeighbour', ->
    game = getTestGameSetup()
    possibleActionsService = new PossibleActionsApplicationService(game, 0)
    possibleActionsService._getDistantNeighbour({x: 2, y: 2}, 2, 0).should.eql {x: 2, y: 0}
    possibleActionsService._getDistantNeighbour({x: 2, y: 2}, 2, 1).should.eql {x: 4, y: 1}
    possibleActionsService._getDistantNeighbour({x: 2, y: 2}, 2, 2).should.eql {x: 4, y: 3}
    possibleActionsService._getDistantNeighbour({x: 2, y: 2}, 2, 3).should.eql {x: 2, y: 4}
    possibleActionsService._getDistantNeighbour({x: 2, y: 2}, 2, 4).should.eql {x: 0, y: 3}
    possibleActionsService._getDistantNeighbour({x: 2, y: 2}, 2, 5).should.eql {x: 0, y: 1}
    possibleActionsService._getDistantNeighbour({x: 2, y: 2}, 3, 2).should.eql {x: 5, y: 3}
    possibleActionsService._getDistantNeighbour({x: 2, y: 2}, 1, 0).should.eql {x: 2, y: 1}
    possibleActionsService._getDistantNeighbour({x: 2, y: 2}, 1, 1).should.eql {x: 3, y: 1}
    possibleActionsService._getDistantNeighbour({x: 2, y: 2}, 1, 2).should.eql {x: 3, y: 2}
    possibleActionsService._getDistantNeighbour({x: 2, y: 2}, 1, 3).should.eql {x: 2, y: 3}
    possibleActionsService._getDistantNeighbour({x: 2, y: 2}, 1, 4).should.eql {x: 1, y: 2}
    possibleActionsService._getDistantNeighbour({x: 2, y: 2}, 1, 5).should.eql {x: 1, y: 1}

    possibleActionsService._getDistantNeighbour({x: 3, y: 3}, 2, 0).should.eql {x: 3, y: 1}
    possibleActionsService._getDistantNeighbour({x: 3, y: 3}, 2, 1).should.eql {x: 5, y: 2}
    possibleActionsService._getDistantNeighbour({x: 3, y: 3}, 2, 2).should.eql {x: 5, y: 4}
    possibleActionsService._getDistantNeighbour({x: 3, y: 3}, 2, 3).should.eql {x: 3, y: 5}
    possibleActionsService._getDistantNeighbour({x: 3, y: 3}, 2, 4).should.eql {x: 1, y: 4}
    possibleActionsService._getDistantNeighbour({x: 3, y: 3}, 2, 5).should.eql {x: 1, y: 2} 
    possibleActionsService._getDistantNeighbour({x: 3, y: 3}, 3, 2).should.eql {x: 6, y: 5}
    possibleActionsService._getDistantNeighbour({x: 3, y: 3}, 1, 0).should.eql {x: 3, y: 2}
    possibleActionsService._getDistantNeighbour({x: 3, y: 3}, 1, 1).should.eql {x: 4, y: 3}
    possibleActionsService._getDistantNeighbour({x: 3, y: 3}, 1, 2).should.eql {x: 4, y: 4}
    possibleActionsService._getDistantNeighbour({x: 3, y: 3}, 1, 3).should.eql {x: 3, y: 4}
    possibleActionsService._getDistantNeighbour({x: 3, y: 3}, 1, 4).should.eql {x: 2, y: 4}
    possibleActionsService._getDistantNeighbour({x: 3, y: 3}, 1, 5).should.eql {x: 2, y: 3}

getTestGameSetup = () ->
  player1 = new Player(0, "#ff0000")
  player2 = new Player(1, "#00ff00")
  board = new Board();
  game = new Game(board, player1, player2)
