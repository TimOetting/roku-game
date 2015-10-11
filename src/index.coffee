GameApplicationService = require('./application/gameApplicationService')
gameApplicationService = new GameApplicationService()

module.exports = exports =
    createNewGame: () ->
        gameApplicationService.createNewGame()

    getPossibleActions: (game, x , y) ->
        gameApplicationService.getPossibleActions(game, x, y)