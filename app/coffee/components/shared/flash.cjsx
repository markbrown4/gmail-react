
@Flash = React.createClass
  render: ->
    <div class={ classNames("flash", {hide: @props.message.length == 0}) }>
      {@props.message}
    </div>
