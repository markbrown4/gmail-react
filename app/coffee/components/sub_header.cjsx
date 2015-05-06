
{ Link } = ReactRouter

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
      <Link to="threads" className={ classNames("btn", { hide: !@state.activeThread }) } title="Back to Inbox">
        <Icon name='back' />
      </Link>
      <BulkOptionsMenu allSelected={@state.allSelected} someSelected={@state.someSelected} />
      <ThreadTools someSelected={@state.someSelected} />
      <a className={ classNames("btn", { hide: @state.activeThread or @state.someSelected }) } onClick={@refresh}><Icon name='refresh' /></a>
    </div>
