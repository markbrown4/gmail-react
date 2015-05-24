
App.Components.DropDown = React.createClass
  getInitialState: ->
    open: false

  toggle: (event)->
    event.stopPropagation()

    @setState open: !@state.open

  render: ->
    classes = classNames("drop-down", @props.className, { active: @state.open })
    <div className={ classes } onClick={@toggle}>
      { @props.children }
    </div>
