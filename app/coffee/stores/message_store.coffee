
message = {}
states = {
  composing: false
}

App.Stores.MessageStore = MessageStore = App.createStore
  getState: ->
    message: message
    states: states

composeNew = ->
  message = {
    fromAccount: currentUser.accounts[0]
  }
  states.composing = true

  MessageStore.emitChange()

updateFromAccount = (account)->
  message.fromAccount = account

  MessageStore.emitChange()

App.Dispatcher.register
  'compose-message': (id)-> composeNew()
  'composer-update-from-account': (account)-> updateFromAccount(account)
