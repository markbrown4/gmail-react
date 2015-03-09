
ThreadListItem = React.createClass
  toggleSelected: (event)->
    event.preventDefault()

    InboxActions.toggleSelected @props.id

  render: ->
    lastMessage = @props.last_message

    threadClasses = React.addons.classSet
      unread: @props.unread
      selected: @props.selected

    <li className={ threadClasses }>
      <a>
        <time>{ lastMessage.created_at }</time>
        <span className="check" onClick={@toggleSelected}></span>
        <span className="people">
          { for person in @props.participants
            <span className="name unread">{ person.first_name } { person.last_name }</span>
          }
        </span>
        <span className="subject">{ lastMessage.subject }</span>
        <span className="body">- { lastMessage.snippet }</span>
      </a>
    </li>
