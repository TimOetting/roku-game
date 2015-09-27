GameApplicationService = require('./domain/gameApplicationService')
gameApplicationService = new GameApplicationService()

module = module.exports = createNewGame: () ->
  gameApplicationService.createNewGame()