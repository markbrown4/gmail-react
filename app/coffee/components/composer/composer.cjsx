
{ MessageStore } = App.Stores
{ ComposerActions, FlashActions } = App.Actions

App.Components.Composer = React.createClass
  getInitialState: ->
    MessageStore.getState()

  componentDidMount: ->
    MessageStore.bind 'change', @onChange

  componentWillUnmount: ->
    MessageStore.unbind 'change', @onChange

  onChange: ->
    state = MessageStore.getState()

    @setState
      message: state.message
      open: state.states.open

  close: ->
    @setState open: false

  activateBCC: ->
    @setState bccActive: true, ->
      @refs["bcc_input"].getDOMNode().focus()

  activateCC: ->
    @setState ccActive: true, ->
      @refs["cc_input"].getDOMNode().focus()

  activateTo: ->
    @setState activeSection: 'to', ->
      @refs["to_input"].getDOMNode().focus()

  activateSection: (section)->
    @setState activeSection: section

  updateFromAccount: (account)->
    ComposerActions.updateFromAccount(account)

  send: ->
    @setState open: false
    FlashActions.newMessage
      message: "Sending..."
      timeout: 3000

  render: ->
    { DropDown } = App.Components

    <div id="compose" className={ classNames(hide: !@state.open) }>
      <div className="header">
        <a className="close" onClick={@close}>×</a>
        <h2>New Message</h2>
      </div>
      <div>
        <div className={ classNames(hide: @state.activeSection == 'to') }>
          <input onFocus={@activateTo} className="full" name="recipients" placeholder="Recipients" />
        </div>
        <div className={ classNames(hide: @state.activeSection != 'to') }>
          <div className="input">
            <label htmlFor="message_to">To</label>
            <div className="fit">
              <input ref="to_input" className="full" id="message_to" />
            </div>
          </div>
          <div className={ classNames("input", { hide: !@state.ccActive }) }>
            <label htmlFor="message_cc">Cc</label>
            <div className="fit">
              <input ref="cc_input" className="full" id="message_cc" />
            </div>
          </div>
          <div className={ classNames("input", {hide: !@state.bccActive}) }>
            <label htmlFor="message_bcc">Bcc</label>
            <div className="fit">
              <input ref="bcc_input" className="full" id="message_bcc" />
            </div>
          </div>
          <div>
            <label>From</label>
            <a onClick={@activateBCC} className={ classNames("bcc", { hide: @state.bccActive }) }>Bcc</a>
            <a onClick={@activateCC} className={ classNames("cc", { hide: @state.ccActive }) }>Cc</a>
            <DropDown className="from-address">
              <span>
                { "#{ @state.message.fromAccount.firstName } #{ @state.message.fromAccount.lastName } <#{ @state.message.fromAccount.email }> " }
              </span>
              <img src="images/icons/down.png" width="7" height="4" />
              <ul className="align-right">
              { for account in currentUser.accounts
                <li key={ 'account-' + account.id }>
                  <a onClick={@updateFromAccount.bind(@, account)}>
                    { "#{ account.firstName } #{ account.lastName } <#{ account.email }>" }
                  </a>
                </li>
              }
              </ul>
            </DropDown>
          </div>
        </div>
      </div>
      <div>
        <input onFocus={@activateSection.bind(@, 'subject')} className="full" placeholder="Subject" id="message_subject" />
      </div>
      <div>
        <textarea onFocus={@activateSection.bind(@, 'body')} placeholder="Body" id="message_body"></textarea>
      </div>
      <div className="footer">
        <input type="submit" onClick={@send} className="btn primary-btn" value="Send" />
      </div>
    </div>
