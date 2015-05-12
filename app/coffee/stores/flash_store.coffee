
message = ''

App.Stores.FlashStore = FlashStore = App.createStore
  getState: ->
    message: message

addFlash = (data)->
  message = data.message
  setTimeout ->
    message = ''
    emitChange()
  , data.timeout || 3000

  FlashStore.emitChange()

App.Dispatcher.register
  'new-flash-message': (data)-> addFlash(data)
