Position = require('./position')

module.exports = class PossibleTurns
  constructor: (@board, position) ->
    @x = position.x
    @y = position.y

  getMoves: () ->
    if @board.tiles[@x][@y]?
      return @getNeighbours(@position)
    else
      []

  getNeighbours: (position) ->
      return [
        new Position(@x, @y - 1)
        new Position(@x + 1, @y - (if @x % 2 == 0 then 1 else 0))
        new Position(@x + 1, @y + (if @x % 2 == 0 then 0 else 1))
        new Position(@x, @y + 1)
        new Position(@x - 1, @y + (if @x % 2 == 0 then 0 else 1))
        new Position(@x - 1, @y - (if @x % 2 == 0 then 1 else 0))
      ]

  isFieldInsideBounds: (position) ->
    if (0 <= @x <= 6 and 0 <= @y <= 5)
      yes
    else
      no