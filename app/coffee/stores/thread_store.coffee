threads = []
activeThread = null
paging = {}

App.Stores.ThreadStore = ThreadStore = App.createStore
  getState: ->
    threads: threads
    activeThread: activeThread
    paging: paging
    allSelected: allSelected()
    someSelected: someSelected()

loadThreads = ->
  activeThread = null
  reqwest "/api/threads/index.json", (data)->
    threads = data
    paging =
      from: 1
      to: data.length
      count: data.length

    ThreadStore.emitChange()

loadThread = (id)->
  reqwest "/api/threads/#{id}.json", (data)=>
    activeThread = data

    ThreadStore.emitChange()

someSelected = ->
  selected = false
  for thread in threads
    selected = true if thread.selected

  selected

noneSelected = ->
  !someSelected()

allSelected = ->
  return false if threads.length == 0

  selected = true
  for thread in threads
    selected = false if !thread.selected

  selected

toggleSelected = (id)->
  thread = _.find threads, (thread)-> thread.id == id
  thread.selected = !thread.selected

  ThreadStore.emitChange()

bulkToggleSelected = ->
  if someSelected()
    selectNone()
  else
    selectAll()

selectAll = ->
  for thread in threads
    thread.selected = true

  ThreadStore.emitChange()

selectNone = ->
  for thread in threads
    thread.selected = false

  ThreadStore.emitChange()

selectRead = ->
  for thread in threads
    thread.selected = !thread.unread

  ThreadStore.emitChange()

selectUnread = ->
  for thread in threads
    thread.selected = thread.unread

  ThreadStore.emitChange()

App.Dispatcher.register
  'load-threads': -> loadThreads()
  'load-thread': (id)-> loadThread(id)
  'toggle-selected-threads': (id)-> toggleSelected(id)
  'bulk-toggle-selected-threads': -> bulkToggleSelected()
  'select-all-threads': -> selectAll()
  'deselect-all-threads': -> selectNone()
  'select-unread-threads': -> selectUnread()
  'select-read-threads': -> selectRead()
