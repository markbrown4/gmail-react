
Link = ReactRouter.Link
smartDate = Filters.smartDate
smartName = Filters.smartName

@ThreadListItem = React.createClass
  toggleSelected: (event)->
    event.preventDefault()

    InboxActions.toggleSelected @props.id

  render: ->
    lastMessage = @props.lastMessage

    threadClasses = React.addons.classSet
      unread: @props.unread
      selected: @props.selected

    peopleList = for person, i in @props.participants
      <span key={"thread-#{@props.id}-#{i}"} className="name unread">
        { smartName(person, @props.messageCount == 1) }
      </span>

    <li className={ threadClasses }>
      <Link to="thread" params={id: @props.id}>
        <time>{ smartDate(lastMessage.createdAt) }</time>
        <span className="check" onClick={@toggleSelected}></span>
        <span className="people">
          { peopleList }
        </span>
        <span className="subject">{ lastMessage.subject }</span>
        <span className="body">- { lastMessage.snippet }</span>
      </Link>
    </li>
