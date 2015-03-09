
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
    thread = _.find @threads, (thread)-> thread.id == id
    thread.selected = !thread.selected

    @trigger 'change'

  bulkToggleSelected: ->
    if @someSelected()
      @selectNone()
    else
      @selectAll()

  selectAll: ->
    for thread in @threads
      thread.selected = true

    @trigger 'change'

  selectNone: ->
    for thread in @threads
      thread.selected = false

    @trigger 'change'

  selectRead: ->
    for thread in @threads
      thread.selected = !thread.unread

    @trigger 'change'

  selectUnread: ->
    for thread in @threads
      thread.selected = thread.unread

    @trigger 'change'

  someSelected: ->
    selected = false
    for thread in @threads
      selected = true if thread.selected

    selected

  noneSelected: ->
    !@someSelected()

  allSelected: ->
    return false if @threads.length == 0

    selected = true
    for thread in @threads
      selected = false if !thread.selected

    selected

MicroEvent.mixin(ThreadStore)
ThreadStore.refresh()

Dispatcher.registerAll
  'toggle-selected': (id)-> ThreadStore.toggleSelected(id)
  'bulk-toggle-selected': -> ThreadStore.bulkToggleSelected()
  'select-all': -> ThreadStore.selectAll()
  'select-none': -> ThreadStore.selectNone()
  'select-unread': -> ThreadStore.selectUnread()
  'select-read': -> ThreadStore.selectRead()
