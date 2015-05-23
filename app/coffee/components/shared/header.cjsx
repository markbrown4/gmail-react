
App.Components.Header = React.createClass

  switchAccount: ->
    ''

  render: ->
    { DropDown } = App.Components

    <div id="header">
      <span id="logo"><img src="images/logo.png" /></span>
      <DropDown className="account-nav">
        <img className="avatar" src="images/avatars/me.jpg" />
        <ul className="align-right">
          { for account in currentUser.accounts
            <li key={ 'account-' + account.id }>
              <a onclick={@switchAccount.bind(@, account)}>
                { "#{ account.firstName } #{ account.lastName } <#{ account.email }>" }
              </a>
            </li>
          }
        </ul>
      </DropDown>
      <form className="search">
        <input name="query" />
        <button type="submit" className="primary-btn">
          <span className="icon-search"></span>
        </button>
      </form>
    </div>
