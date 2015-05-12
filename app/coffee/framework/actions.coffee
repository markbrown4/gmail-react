
Actions =
  dispatch: (name, payload)->
    App.Dispatcher.trigger name, payload

App.createActions = (obj)->
  Object.assign(Object.create(Actions), obj)
