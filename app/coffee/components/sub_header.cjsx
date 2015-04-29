
@SubHeader = React.createClass
  getInitialState: ->
    ThreadStore.getState()

  componentDidMount: ->
    ThreadStore.bind 'change', @onChange

  componentWillUnmount: ->
    ThreadStore.unbind 'change', @onChange

  onChange: ->
    @setState ThreadStore.getState()

  refresh: ->
    InboxActions.loadThreads()

  render: ->
    <div id="sub-header">
      <h1 className="app-name"><span>Re</span>Mail</h1>
      <Pagination {...@state.paging} />
      <a className="btn" title="Back to Inbox" style={display:'none'}><Icon name='back' /></a>
      <BulkOptionsMenu allSelected={@state.allSelected} someSelected={@state.someSelected} />
      <ThreadTools someSelected={@state.someSelected} />
      <a className="btn" onClick={@refresh}><Icon name='refresh' /></a>
    </div>
