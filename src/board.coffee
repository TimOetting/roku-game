module.exports = class Board

  constructor: () ->
    @tiles = (null for [0..5] for [0..6]) # for y for x