Position = require('./position')

module.exports = class PossibleTurns
  constructor: (@board, @position) ->
    x = @position.x
    y = @position.y

    @neighbours = [
      new Position(x, y - 1)
      new Position(x + 1, y - (if x % 2 == 0 then 0 else 1))
      new Position(x + 1, y + (if x % 2 == 0 then 1 else 0))
      new Position(x, y + 1)
      new Position(x - 1, y + (if x % 2 == 0 then 1 else 0))
      new Position(x - 1, y - (if x % 2 == 0 then 0 else 1))
    ]

    for n, i in @neighbours
      if not @isFieldInsideBounds(n)
        @neighbours[i] = null

  isFieldInsideBounds: () ->
    0 <= @position.x <= 6 and 0 <= @position.y <= 5

  isFieldEmpty: (position) ->
    if @isFieldInsideBounds(position)
      not @board.tiles[@position.x][@position.y]?
    else
      no

  getSwordAttacks: () ->
    possibilities = []

    token = board.tiles[position.x][position.y]
    swords = (i for i in [0..5] when token.sides[i] == Weapon.sword)

    for i in swords when @neighbours[i] not null
      neighbourToken = @board.tiles[@neighbours[i].x][@neighbours[i].y]
      if neighbourToken not null
        if token.playerId != neighbourToken.playerId and neighbourToken.sides[(i + 3) % 6] != Weapon.shield
          possibilities.push(@neighbours[i])

    possibilities

  getMoves: () ->
    possibilities = []

