Link = ReactRouter.Link

@ThreadListItem = React.createClass
  toggleSelected: (event)->
    event.preventDefault()

    InboxActions.toggleSelected @props.id

  render: ->
    lastMessage = @props.lastMessage

    threadClasses = React.addons.classSet
      unread: @props.unread
      selected: @props.selected

    <li className={ threadClasses }>
      <Link to="thread" params={id: @props.id}>
        <time>{ lastMessage.createdAt }</time>
        <span className="check" onClick={@toggleSelected}></span>
        <span className="people">
          { for person, i in @props.participants
            <span key={"thread-#{@props.id}-#{i}"} className="name unread">
              { person.firstName } { person.lastName }
            </span>
          }
        </span>
        <span className="subject">{ lastMessage.subject }</span>
        <span className="body">- { lastMessage.snippet }</span>
      </Link>
    </li>
