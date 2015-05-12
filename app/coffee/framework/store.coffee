
Store =
  emitChange: ->
    @trigger 'change'

  mixin: {
    componentDidMount: ->
      console.log this
      @bind 'change', @onChange

    componentWillUnmount: ->
      @unbind 'change', @onChange
  }

App.createStore = (obj)->
  store = Object.assign(Object.create(Store), obj)
  MicroEvent.mixin store

  store
