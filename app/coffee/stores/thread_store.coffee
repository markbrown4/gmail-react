
@ThreadStore =
  threads: []
  thread: { messages: [] }
  paging: {}

  getState: ->
    threads: @threads
    thread: @thread
    paging: @paging
    allSelected: @allSelected()
    someSelected: @someSelected()

  loadThreads: ->
    reqwest "/api/threads/index.json", (threads)=>
      @threads = threads
      @paging =
        from: 1
        to: threads.length
        count: threads.length

      @trigger 'change'

  loadThread: (id)->
    reqwest "/api/threads/#{id}.json", (thread)=>
      @thread = thread

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

MicroEvent.mixin(ThreadStore)
ThreadStore.loadThreads()

Dispatcher.register
  'load-threads': -> ThreadStore.loadThreads()
  'load-thread': (id)-> ThreadStore.loadThread(id)
  'toggle-selected': (id)-> ThreadStore.toggleSelected(id)
  'bulk-toggle-selected': -> ThreadStore.bulkToggleSelected()
  'select-all': -> ThreadStore.selectAll()
  'select-none': -> ThreadStore.selectNone()
  'select-unread': -> ThreadStore.selectUnread()
  'select-read': -> ThreadStore.selectRead()
