
{ ThreadResource } = App.Resources

App.Actions.InboxActions = InboxActions = App.createActions
  loadThreads: ->
    @dispatch 'load-threads'
    ThreadResource.query().then (data)->
      InboxActions.dispatch 'load-threads-success', data
    , (data)->
      InboxActions.dispatch 'load-threads-error', data

  loadThread: (id)->
    @dispatch 'load-thread'
    ThreadResource.get(id).then (data)->
      InboxActions.dispatch 'load-thread-success', data
    , (data)->
      InboxActions.dispatch 'load-thread-error', data

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

  previousPage: -> ''

  nextPage: -> ''

