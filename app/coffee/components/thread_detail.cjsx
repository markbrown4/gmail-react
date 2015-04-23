@ThreadDetail = React.createClass
  mixins: [ReactRouter.State]
  getInitialState: ->
    ThreadStore.getState()

  componentDidMount: ->
    id = @getParams().id
    InboxActions.loadThread(id)
    ThreadStore.bind 'change', @onChange

  componentWillUnmount: ->
    ThreadStore.unbind 'change', @onChange

  onChange: ->
    @setState ThreadStore.getState()

  render: ->
    <div id="wrapper">
      <Header />
      <SubHeader {...@state} />
      <Nav />
      <div id="content">
        <Thread {...@state.thread} />
      </div>
    </div>
