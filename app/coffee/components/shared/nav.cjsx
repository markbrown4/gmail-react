
{ Link } = ReactRouter
{ InboxActions } = App.Actions

App.Components.Nav = React.createClass
  compose: (event)->
    event.preventDefault()

    InboxActions.composeMessage()

  render: ->
    <div id="nav">
      <a className="compose" onClick={@compose}>COMPOSE</a>
      <ul>
        <li><Link to="threads">Inbox</Link></li>
        <li><a>Sent Mail</a></li>
        <li><a>Drafts</a></li>
        <li><a>Trash</a></li>
      </ul>
    </div>
