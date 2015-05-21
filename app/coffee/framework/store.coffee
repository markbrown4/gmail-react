
Store =
  emitChange: ->
    @trigger 'change'

App.createStore = (obj)->
  store = Object.assign(Object.create(Store), obj)
  MicroEvent.mixin store

  store
