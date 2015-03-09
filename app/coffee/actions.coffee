
dispatch = Dispatcher.dispatch

@InboxActions =
  toggleSelected: (id)->
    dispatch 'toggle-selected', id

  bulkToggleSelected: ->
    dispatch 'bulk-toggle-selected'

  selectAll: ->
    dispatch 'select-all'

  selectNone: ->
    dispatch 'select-none'

  selectUnread: ->
    dispatch 'select-unread'

  selectRead: ->
    dispatch 'select-read'

  composeMessage: ->
    dispatch 'compose-message'
