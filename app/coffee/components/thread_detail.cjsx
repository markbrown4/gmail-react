@ThreadDetail = React.createClass
  mixins: [ReactRouter.State]
  getInitialState: ->
    ThreadStore.getState()

  componentDidMount: ->
    id = @getParams().id
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
        <Thread {...@state} />
      </div>
    </div>
