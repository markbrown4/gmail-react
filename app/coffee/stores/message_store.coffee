
message = {
  fromAccount: currentUser.accounts[0]
}
states = {
  open: false
  activeSection: false
  bccActive: false
  ccActive: false
}

App.Stores.MessageStore = MessageStore = App.createStore
  getState: ->
    message: message
    states: states

composeNew = ->
  message = {
    fromAccount: currentUser.accounts[0]
  }
  states.open = true
  MessageStore.emitChange()

updateFromAccount = (account)->
  message.fromAccount = account

  MessageStore.emitChange()

App.Dispatcher.register
  'compose-message': (id)-> composeNew()
  'composer-update-from-account': (account)-> updateFromAccount(account)
