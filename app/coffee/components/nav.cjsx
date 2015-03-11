
@Nav = React.createClass
  render: ->
    <div id="nav">
      <a className="compose">COMPOSE</a>
      <ul>
        <li className="active"><a>Inbox</a></li>
        <li><a>Sent Mail</a></li>
        <li><a>Drafts</a></li>
        <li><a>Trash</a></li>
      </ul>
    </div>
