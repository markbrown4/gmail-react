
{ ThreadStore } = App.Stores
{ InboxActions } = App.Actions

App.Components.ThreadDetail = React.createClass
  mixins: [ReactRouter.State]
  getInitialState: ->
    messages: []

  componentDidMount: ->
    id = @getParams().id
    InboxActions.loadThread(id)
    ThreadStore.bind 'change', @onChange

  componentWillUnmount: ->
    ThreadStore.unbind 'change', @onChange

  onChange: ->
    @setState ThreadStore.getState().activeThread

  render: ->
    { Message } = App.Components

    <div id="thread">
      <h1>{ if @state.messages.length > 0 then @state.messages[0].subject else '' }</h1>
      <ul className="messages">
        { for message, i in @state.messages
          <Message key={ 'message-' + message.id }  last={i == @state.messages.length - 1} {...message} />
        }
      </ul>
      <div className="reply">
        <img className="avatar" src={currentAccount.avatarUrl} />
        <div className="reply-box">
          <p>Click here to <a href>Reply</a>, <a href>Reply to all</a> or <a href>Forward</a></p>
        </div>
      </div>
    </div>
