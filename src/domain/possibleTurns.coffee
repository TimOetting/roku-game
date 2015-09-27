Position = require('./position')
Weapon = require('./weapon')

module.exports = class PossibleTurns
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

  getSwordAttacks: () ->
    possibilities = []

    token = @board.tiles[@position.x][@position.y]
    swords = (i for i in [0..5] when token.sides[i] == Weapon.sword)

    for i in swords when @neighbours[i]?
      neighbourToken = @board.tiles[@neighbours[i].x][@neighbours[i].y]
      if neighbourToken?
        if token.playerId != neighbourToken.playerId and neighbourToken.sides[(i + 3) % 6] != Weapon.shield
          possibilities.push(@neighbours[i])

    possibilities

  getArrowAttacks: () ->
    possibilities = []

    token = @board.tiles[@position.x][@position.y]
    arrows = (i for i in [0..5] when token.sides[i] == Weapon.arrow)

    for i in arrows
      maxX = 6
      maxY = 5
      switch i
        when 0
          x = @position.x
          y = @position.y - 1
          while y >= 0 and not @board.tiles[x][y]?
            y--
          possibleTargetToken = @board.tiles[x][y]
          if y >= 0 and possibleTargetToken?
            if token.playerId != possibleTargetToken.playerId and possibleTargetToken.sides[3] != Weapon.shield
              possibilities.push(new Position(x, y))

        when 1
          x = @position.x + 1
          y = @position.y - (if x % 2 == 0 then 1 else 0)
          while x <= maxX and y >= 0 and not @board.tiles[x][y]?
            x++
            y -= (if x % 2 == 0 then 1 else 0)
          possibleTargetToken = @board.tiles[x][y]
          if x <= maxX and y >= 0 and possibleTargetToken?
            if token.playerId != possibleTargetToken.playerId and possibleTargetToken.sides[4] != Weapon.shield
              possibilities.push(new Position(x, y))

        when 2
          x = @position.x + 1
          y = @position.y + (if x % 2 == 0 then 0 else 1)
          while x <= maxX and y <= maxY and not @board.tiles[x][y]?
            x++
            y += (if x % 2 == 0 then 0 else 1)
          possibleTargetToken = @board.tiles[x][y]
          if x <= maxX and y <= maxY and possibleTargetToken?
            if token.playerId != possibleTargetToken.playerId and possibleTargetToken.sides[5] != Weapon.shield
              possibilities.push(new Position(x, y))

        when 3
          x = @position.x
          y = @position.y + 1
          while y <= maxY and not @board.tiles[x][y]?
            y++
          possibleTargetToken = @board.tiles[x][y]
          if y <= maxY and possibleTargetToken?
            if token.playerId != possibleTargetToken.playerId and possibleTargetToken.sides[0] != Weapon.shield
              possibilities.push(new Position(x, y))

        when 4
          x = @position.x - 1
          y = @position.y + (if x % 2 == 0 then 0 else 1)
          while x >= 0 and y <= maxY and not @board.tiles[x][y]?
            x--
            y += (if x % 2 == 0 then 0 else 1)
          possibleTargetToken = @board.tiles[x][y]
          if x >= 0 and y <= maxY and possibleTargetToken?
            if token.playerId != possibleTargetToken.playerId and possibleTargetToken.sides[1] != Weapon.shield
              possibilities.push(new Position(x, y))

        when 5
          x = @position.x - 1
          y = @position.y - (if x % 2 == 0 then 1 else 0)
          while x >= 0 and y >= 0 and not @board.tiles[x][y]?
            x--
            y -= (if x % 2 == 0 then 1 else 0)
          possibleTargetToken = @board.tiles[x][y]
          if x >= 0 and y >= 0 and possibleTargetToken?
            if token.playerId != possibleTargetToken.playerId and possibleTargetToken.sides[2] != Weapon.shield
              possibilities.push(new Position(x, y))

    possibilities

  getMoves: () ->
    possibilities = []
    for n in @neighbours when n?
      if not @board.tiles[n.x][n.y]?
        possibilities.push(n)
    possibilities
