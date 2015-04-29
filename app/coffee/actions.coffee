
@InboxActions =
  dispatch: (eventName, obj)->
    Dispatcher.trigger eventName, obj

  loadThreads: ->
    @dispatch 'load-threads'

  loadThread: (id)->
    @dispatch 'load-thread', id

  toggleSelected: (id)->
    @dispatch 'toggle-selected-threads', id

  bulkToggleSelected: ->
    @dispatch 'bulk-toggle-selected-threads'

  selectAll: ->
    @dispatch 'select-all-threads'

  selectNone: ->
    @dispatch 'deselect-all-threads'

  selectUnread: ->
    @dispatch 'select-unread-threads'

  selectRead: ->
    @dispatch 'select-read-threads'

  composeMessage: ->
    @dispatch 'compose-message'
