
{ ThreadStore } = App.Stores
{ InboxActions } = App.Actions

App.Components.ThreadList = React.createClass
  getInitialState: ->
    ThreadStore.getState()

  componentDidMount: ->
    InboxActions.loadThreads()

    ThreadStore.bind 'change', @onChange

  componentWillUnmount: ->
    ThreadStore.unbind 'change', @onChange

  onChange: ->
    @setState ThreadStore.getState()

  render: ->
    { ThreadListItem } = App.Components

    <ul id="threads">
      { for thread in @state.threads
        <ThreadListItem key={ 'thread-' + thread.id } {...thread} />
      }
    </ul>
