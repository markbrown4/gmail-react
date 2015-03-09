
ThreadList = React.createClass
  render: ->
    <ul id="threads">
      { for thread in @props.threads
        <ThreadListItem thread={thread} />
      }
    </ul>
