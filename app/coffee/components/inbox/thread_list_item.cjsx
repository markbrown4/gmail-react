
{ Link } = ReactRouter
{ smartDate, smartName } = App.Filters
{ InboxActions } = App.Actions

App.Components.ThreadListItem = React.createClass
  toggleSelected: (event)->
    event.preventDefault()

    InboxActions.toggleSelected @props.id

  render: ->
    lastMessage = _.last @props.messages

    threadClasses = classNames
      unread: @props.unread
      selected: @props.selected

    peopleList = for person, i in @props.participants
      <span key={"thread-#{@props.id}-#{i}"} className="name unread">
        { smartName(person, @props.messageCount == 1) + (if i == @props.participants.length - 1 then '' else ', ') }
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
