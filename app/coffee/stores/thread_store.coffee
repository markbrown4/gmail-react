threads = []
activeThread = { messages: [] }
paging = {}

@ThreadStore =
  getState: ->
    threads: threads
    activeThread: activeThread
    paging: paging
    allSelected: allSelected()
    someSelected: someSelected()

MicroEvent.mixin(ThreadStore)

emitChange = ->
  ThreadStore.trigger 'change'

loadThreads = ->
  reqwest "/api/threads/index.json", (data)->
    threads = data
    paging =
      from: 1
      to: data.length
      count: data.length

    emitChange()

loadThread = (id)->
  reqwest "/api/threads/#{id}.json", (data)=>
    activeThread = data

    emitChange()

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

  emitChange()

bulkToggleSelected = ->
  if someSelected()
    selectNone()
  else
    selectAll()

selectAll = ->
  for thread in threads
    thread.selected = true

  emitChange()

selectNone = ->
  for thread in threads
    thread.selected = false

  emitChange()

selectRead = ->
  for thread in threads
    thread.selected = !thread.unread

  emitChange()

selectUnread = ->
  for thread in threads
    thread.selected = thread.unread

  emitChange()

Dispatcher.register
  'load-threads': -> loadThreads()
  'load-thread': (id)-> loadThread(id)
  'toggle-selected-threads': (id)-> toggleSelected(id)
  'bulk-toggle-selected-threads': -> bulkToggleSelected()
  'select-all-threads': -> selectAll()
  'deselect-all-threads': -> selectNone()
  'select-unread-threads': -> selectUnread()
  'select-read-threads': -> selectRead()
