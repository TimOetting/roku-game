Weapon = require('../src/weapon')

module.exports = class GameToken
  constructor: (@playerId) ->
    @health = 10
    @sides = [
           Weapon.shield
           Weapon.sword
           Weapon.arrow
           Weapon.shield
           Weapon.sword
           Weapon.arrow
       ]
