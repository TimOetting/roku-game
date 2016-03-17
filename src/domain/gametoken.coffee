Weapon = require('./weapon')

module.exports = class GameToken
  constructor: (@playerId) ->
    @health = 10
    @isAlive = true
    @sides = [
        {isReady: true, weapon: Weapon.shield}
        {isReady: true, weapon: Weapon.sword}
        {isReady: true, weapon: Weapon.arrow}
        {isReady: true, weapon: Weapon.none}
        {isReady: true, weapon: Weapon.sword}
        {isReady: true, weapon: Weapon.arrow}
      ]
    @possibleActions = 
      moves: []
      swordAttacks: []
      arrowAttacks: []
