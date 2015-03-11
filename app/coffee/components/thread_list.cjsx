
@ThreadList = React.createClass
  render: ->
    <ul id="threads">
      { for thread in @props.threads
        <ThreadListItem key={ 'thread-' + thread.id } {...thread} />
      }
    </ul>
