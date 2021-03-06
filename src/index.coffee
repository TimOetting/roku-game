GameApplicationService = require('./application/gameApplicationService')
gameApplicationService = new GameApplicationService()

module.exports = exports =
  createNewGame: () ->
    gameApplicationService.createNewGame()

  getPossibleActions: (game, x , y) ->
    gameApplicationService.getPossibleActions game, x, y
  
  rotate: (game, tokenId, steps) ->
    gameApplicationService.rotate game, tokenId, steps

  move: (game, tokenId, position) ->
    gameApplicationService.move game, tokenId, position

  attack: (game, attackerTokenId, targetTokenId) ->
    gameApplicationService.attack game, attackerTokenId, targetTokenId