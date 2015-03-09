
@ThreadStore =
  threads: []

  refresh: ->
    $.ajax(url: '/api/threads/index.json', cache: false)
      .then (threads)=>
        @threads = threads
        @trigger 'change'

  getState: ->
    threads: @threads

  toggleSelected: (id)->
    thread = @threads.find (thread)-> thread.id == id
    thread.selected = !thread.selected

    @trigger 'change'


MicroEvent.mixin(ThreadStore)
ThreadStore.refresh()

Dispatcher.registerAll
  'toggle-selected': (id)-> ThreadStore.toggleSelected(id)
