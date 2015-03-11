
@Header = React.createClass
  render: ->
    <div id="header">
      <span id="logo"><img src="images/logo.png" /></span>
      <div className="drop-down account-nav">
        <img className="avatar" src="images/avatars/me.jpg" />
        <ul className="align-right">
          <li><a>Mark Brown &lt;markbrown4@gmail.com&gt;</a></li>
          <li><a>Mark Brown &lt;mark@inspire9.com&gt;</a></li>
          <li><a>Mark Brown &lt;mark@adioso.com&gt;</a></li>
        </ul>
      </div>
      <form className="search">
        <input name="query" />
        <button type="submit" className="primary-btn">
          <span className="icon-search"></span>
        </button>
      </form>
    </div>
