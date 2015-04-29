
@ThreadDetail = React.createClass
  mixins: [ReactRouter.State]
  getInitialState: ->
    ThreadStore.getState().activeThread

  componentDidMount: ->
    id = @getParams().id
    InboxActions.loadThread(id)
    ThreadStore.bind 'change', @onChange

  componentWillUnmount: ->
    ThreadStore.unbind 'change', @onChange

  onChange: ->
    @setState ThreadStore.getState().activeThread

  render: ->
    <div id="thread">
      <h1>{ if @state.messages.length > 0 then @state.messages[0].subject else ''}</h1>
      <ul className="messages">
        { for message in @state.messages
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
