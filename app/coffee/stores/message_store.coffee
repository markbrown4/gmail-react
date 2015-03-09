
@MessageStore =
  newMessage: {}

  composeNew: ->
    newMessage: {}

MicroEvent.mixin(MessageStore)

Dispatcher.register
  'compose-message': (id)-> MessageStore.composeNew()
