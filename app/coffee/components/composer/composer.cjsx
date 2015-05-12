
{ MessageStore } = App.Stores
{ ComposerActions, AppActions } = App.Actions

App.Components.Composer = React.createClass
  getInitialState: ->
    message: {
      fromAccount: currentUser.accounts[0]
    }
    open: false
    activeSection: false
    bccActive: false
    ccActive: false

  componentDidMount: ->
    MessageStore.bind 'change', @onChange

  componentWillUnmount: ->
    MessageStore.unbind 'change', @onChange

  onChange: ->
    state = MessageStore.getState()
    @setState message: state.message
    if state.states.composing
      @setState open: true

  close: ->
    @setState open: false

  activateBCC: ->
    @setState bccActive: true

  activateCC: ->
    @setState ccActive: true

  activateSection: (section)->
    @setState activeSection: section

  updateFromAccount: (account)->
    ComposerActions.updateFromAccount(account)

  send: ->
    @setState open: false
    AppActions.showFlash
      message: "Sending"
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
          <input onFocus={@activateSection.bind(@, 'to')} className="full" name="recipients" placeholder="Recipients" />
        </div>
        <div className={ classNames(hide: @state.activeSection != 'to') }>
          <div className="input">
            <label for="message_to">To</label>
            <div className="fit">
              <input focus-when="active_section == 'to'" className="full" id="message_to" />
            </div>
          </div>
          <div className={ classNames("input", { hide: !@state.ccActive }) }>
            <label for="message_cc">Cc</label>
            <div className="fit">
              <input focus-when="cc_active" className="full" id="message_cc" />
            </div>
          </div>
          <div className={ classNames("input", {hide: !@state.bccActive}) }>
            <label for="message_bcc">Bcc</label>
            <div className="fit">
              <input focus-when="bcc_active" className="full" for="message_bcc" />
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
                <li>
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
