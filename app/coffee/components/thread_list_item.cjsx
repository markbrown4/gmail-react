
ThreadListItem = React.createClass
  toggleSelected: (event)->
    event.preventDefault()

    InboxActions.toggleSelected @props.thread.id

  render: ->
    thread = @props.thread
    lastMessage = thread.last_message
    threadClasses = React.addons.classSet
      unread: thread.unread
      selected: thread.selected

    <li className={ threadClasses }>
      <a>
        <time>{ lastMessage.created_at }</time>
        <span className="check" onClick={@toggleSelected}></span>
        <span className="people">
          { for person in thread.participants
            <span className="name unread">{ person.first_name } { person.last_name }</span>
          }
        </span>
        <span className="subject">{ lastMessage.subject }</span>
        <span className="body">- { lastMessage.snippet }</span>
      </a>
    </li>
