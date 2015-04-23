@Thread = React.createClass
  render: ->

    <div id="thread">
      <h1>{ if @props.messages.length > 0 then @props.messages[0].subject else ''}</h1>
      <ul className="messages">
        { for message in @props.messages
          <Message key={ 'message-' + message.id } {...message} />
        }
      </ul>
      <div className="reply">
        <img className="avatar" src={currentUser.avatarUrl} />
        <div className="reply-box">
          <p>Click here to <a href>Reply</a>, <a href>Reply to all</a> or <a href>Forward</a></p>
        </div>
      </div>
    </div>
