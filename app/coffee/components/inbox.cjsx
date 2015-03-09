
Inbox = React.createClass
  getInitialState: ->
    ThreadStore.getState()

  componentDidMount: ->
    ThreadStore.bind 'change', @onChange

  componentWillUnmount: ->
    ThreadStore.unbind 'change', @onChange

  onChange: ->
    @setState ThreadStore.getState()

  render: ->
    <div id="wrapper">
      <Header />
      <SubHeader />
      <Nav />
      <div id="content">
        <ThreadList threads={@state.threads} />
      </div>
    </div>
