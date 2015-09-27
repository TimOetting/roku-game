GameApplicationService = require('./domain/gameApplicationService')
gameApplicationService = new GameApplicationService()

module.exports = createNewGame: () ->
  gameApplicationService.createNewGame()