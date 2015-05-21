
message = ''

App.Stores.FlashStore = FlashStore = App.createStore
  getState: ->
    message: message

flashTimeout = null
updateMessage = (data)->
  message = data.message
  FlashStore.emitChange()

  clearTimeout(flashTimeout) if flashTimeout?
  flashTimeout = setTimeout ->
    message = ''
    FlashStore.emitChange()
  , data.timeout || 1000

App.Dispatcher.register
  'flash-new-message': (data)-> updateMessage(data)
