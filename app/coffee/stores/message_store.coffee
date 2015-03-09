
@MessageStore =
  newMessage: {}

  composeNew: ->
    newMessage: {}

MicroEvent.mixin(MessageStore)

Dispatcher.registerAll
  'compose-message': (id)-> MessageStore.composeNew()