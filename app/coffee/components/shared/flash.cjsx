
{ FlashStore } = App.Stores

App.Components.Flash = React.createClass
  getInitialState: ->
    FlashStore.getState()

  componentDidMount: ->
    FlashStore.bind 'change', @onChange

  componentWillUnmount: ->
    FlashStore.unbind 'change', @onChange

  onChange: ->
    @setState FlashStore.getState()

  render: ->
    <div className={ classNames("flash", {hide: @state.message.length == 0}) }>
      <div className="inner">{@state.message}</div>
    </div>
