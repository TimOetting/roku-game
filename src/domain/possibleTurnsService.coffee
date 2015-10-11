Position = require('./position')
Weapon = require('./weapon')

module.exports = class PossibleTurnsService
  constructor: (@board, @position) ->
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

  hasToken: (position) ->
    for token in @board.gameTokens
      if position.x == token.position.x and position.y == token.position.y
        return token
    null

  getMoves: () ->
    possibilities = []
    for n in @neighbours when n?
      if not @hasToken(n)?
        possibilities.push(n)
    possibilities

  getSwordAttacks: () ->
    possibilities = []
    token = @hasToken(@position)

    unless token?
      return possibilities

    swords = (i for i in [0..5] when token.sides[i] == Weapon.sword)

    for i in swords when @neighbours[i]?
      neighbourToken = @hasToken(@neighbours[i])
      if neighbourToken?
        if token.playerId != neighbourToken.playerId and neighbourToken.sides[(i + 3) % 6] != Weapon.shield
          possibilities.push(@neighbours[i])

    possibilities

  getArrowAttacks: () ->
    possibilities = []
    token = @hasToken(@position)

    unless token?
      return possibilities

    arrows = (i for i in [0..5] when token.sides[i] == Weapon.arrow)

    for i in arrows
      maxX = 6
      maxY = 5
      switch i
        when 0
          x = @position.x
          y = @position.y - 1
          while y >= 0 and not @hasToken(new Position(x, y))?
            y--
          possibleTargetToken = @hasToken(new Position(x, y))
          if y >= 0 and possibleTargetToken?
            if token.playerId != possibleTargetToken.playerId and possibleTargetToken.sides[3] != Weapon.shield
              possibilities.push(new Position(x, y))

        when 1
          x = @position.x + 1
          y = @position.y - (if x % 2 == 0 then 1 else 0)
          while x <= maxX and y >= 0 and not @hasToken(new Position(x, y))?
            x++
            y -= (if x % 2 == 0 then 1 else 0)
          possibleTargetToken = @hasToken(new Position(x, y))
          if x <= maxX and y >= 0 and possibleTargetToken?
            if token.playerId != possibleTargetToken.playerId and possibleTargetToken.sides[4] != Weapon.shield
              possibilities.push(new Position(x, y))

        when 2
          x = @position.x + 1
          y = @position.y + (if x % 2 == 0 then 0 else 1)
          while x <= maxX and y <= maxY and not @hasToken(new Position(x, y))?
            x++
            y += (if x % 2 == 0 then 0 else 1)
          possibleTargetToken = @hasToken(new Position(x, y))
          if x <= maxX and y <= maxY and possibleTargetToken?
            if token.playerId != possibleTargetToken.playerId and possibleTargetToken.sides[5] != Weapon.shield
              possibilities.push(new Position(x, y))

        when 3
          x = @position.x
          y = @position.y + 1
          while y <= maxY and not @hasToken(new Position(x, y))?
            y++
          possibleTargetToken = @hasToken(new Position(x, y))
          if y <= maxY and possibleTargetToken?
            if token.playerId != possibleTargetToken.playerId and possibleTargetToken.sides[0] != Weapon.shield
              possibilities.push(new Position(x, y))

        when 4
          x = @position.x - 1
          y = @position.y + (if x % 2 == 0 then 0 else 1)
          while x >= 0 and y <= maxY and not @hasToken(new Position(x, y))?
            x--
            y += (if x % 2 == 0 then 0 else 1)
          possibleTargetToken = @hasToken(new Position(x, y))
          if x >= 0 and y <= maxY and possibleTargetToken?
            if token.playerId != possibleTargetToken.playerId and possibleTargetToken.sides[1] != Weapon.shield
              possibilities.push(new Position(x, y))

        when 5
          x = @position.x - 1
          y = @position.y - (if x % 2 == 0 then 1 else 0)
          while x >= 0 and y >= 0 and not @hasToken(new Position(x, y))?
            x--
            y -= (if x % 2 == 0 then 1 else 0)
          possibleTargetToken = @hasToken(new Position(x, y))
          if x >= 0 and y >= 0 and possibleTargetToken?
            if token.playerId != possibleTargetToken.playerId and possibleTargetToken.sides[2] != Weapon.shield
              possibilities.push(new Position(x, y))

    possibilities
