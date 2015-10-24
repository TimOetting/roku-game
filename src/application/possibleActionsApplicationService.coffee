Position = require('../domain/position')
Weapon = require('../domain/weapon')
PossibleActions = require('../domain/possibleActions')
Config = require('../config/gameConfig')

module.exports = class PossibleActionsApplicationService
  constructor: (@game, tokenId) ->
    @position = @game.board.gameTokens[tokenId].position
    x = @position.x
    y = @position.y

    @neighbours = [
      new Position(x, y - 1)
      new Position(x + 1, y - (if x % 2 == 0 then 1 else 0))
      new Position(x + 1, y + (if x % 2 == 0 then 0 else 1))
      new Position(x, y + 1)
      new Position(x - 1, y + (if x % 2 == 0 then 0 else 1))
      new Position(x - 1, y - (if x % 2 == 0 then 1 else 0))
    ]

    for n, i in @neighbours
      if not @isFieldInsideBounds(n)
        @neighbours[i] = null

  isFieldInsideBounds: () ->
    0 <= @position.x <= 6 and 0 <= @position.y <= 5

  getToken: (position) ->
    for token in @game.board.gameTokens
      if position.x == token.position.x and position.y == token.position.y
        return token
    null

  getPossibleActions: () ->
    new PossibleActions @getMoves(), @getSwordAttacks(), @getArrowAttacks()

  getMoves: () ->
    possibilities = []
    for n in @neighbours when n?
      if not @getToken(n)?
        possibilities.push(n)
    possibilities

  getSwordAttacks: () ->
    possibilities = []
    token = @getToken(@position)

    unless token?
      return possibilities

    swords = (i for i in [0..5] when token.sides[i].weapon == Weapon.sword)

    for i in swords when @neighbours[i]?
      neighbourToken = @getToken(@neighbours[i])
      if neighbourToken?
        if token.playerId != neighbourToken.playerId and 
        neighbourToken.sides[(i + 3) % 6].weapon != Weapon.shield and 
        token.sides[i].isReady
          possibilities.push
            side: i
            targetId: neighbourToken.id

    possibilities

  getArrowAttacks: () ->
    possibilities = []
    token = @getToken(@position)
    console.log token
    unless token?
      return possibilities

    arrows = (i for i in [0..5] when token.sides[i].weapon == Weapon.arrow)

    for i in arrows
      distance = 0
      console.log '>>>>>>>>>>>>>'
      for distance in [1..Config.ARROW_MAX_DISTANCE]
        neighbourToken = @getToken(@_getDistantNeighbour(@position, distance, i))
        if neighbourToken? and 
        neighbourToken.playerId isnt token.playerId and
        neighbourToken.sides[(i + 3) % 6].weapon != Weapon.shield
          console.log 'dingo'
          possibilities.push
            side: i
            targetId: neighbourToken.id
          break
    possibilities

  _getDistantNeighbour: (pos, distance, direction) ->
    directionVector = switch
      when direction is 0 then {x: 0, y: -1}
      when direction is 1 then {x: 1, y: -1}
      when direction is 2 then {x: 1, y: 1}
      when direction is 3 then {x: 0, y: 1}
      when direction is 4 then {x: -1, y: 1}
      when direction is 5 then {x: -1, y: -1}

    outPos = 
      x: pos.x
      y: pos.y
    if directionVector.x != 0
      if pos.x % 2 == 0
        outPos.y += Math.floor (directionVector.y * distance) / 2
      else
        outPos.y += Math.ceil (directionVector.y * distance) / 2
    else
      outPos.y += directionVector.y * distance
    outPos.x += directionVector.x * distance
    outPos

