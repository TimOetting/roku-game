GameApplicationService = require('./domain/gameApplicationService')
gameApplicationService = new GameApplicationService()

exports = module.exports = createNewGame: () ->
  gameApplicationService.createNewGame()