
window.currentUser = null
window.currentAccount = null

App.Stores.AppStore = AppStore = App.createStore
  getState: -> {}

updateCurrentUser = (data)->
  window.currentUser = data
  window.currentAccount = data.currentAccount

  AppStore.emitChange()

updateCurrentAccount = (data)->
  window.currentAccount = data

  AppStore.emitChange()

App.Dispatcher.register
  'current-user-load-success': (data)-> updateCurrentUser(data)
  'switch-account': (data)-> updateCurrentAccount(data)
