
SubHeader = React.createClass
  bulkToggleSelected: (event)->
    event.preventDefault()

    InboxActions.bulkToggleSelected()

  render: ->
    <div id="sub-header">
      <h1 className="app-name"><span>n</span>Gmail</h1>
      <div className="paging">
        <strong>1-2</strong>
        of
        <strong>2</strong>
        <div className="split-btn">
          <a className="btn btn-mini" title="Previous"><img src="images/icons/prev.png" /></a>
          <a className="btn btn-mini" title="Next"><img src="images/icons/next.png" /></a>
        </div>
      </div>

      <a className="btn" title="Back to Inbox" style={display:'none'}><img src="images/icons/back.png" /></a>
      <div className="drop-down btn" onClick={@bulkToggleSelected}>
        <a className="check"></a>
        <img src="images/icons/down.png" />
        <ul>
          <li><a>All</a></li>
          <li><a>None</a></li>
          <li><a>Read</a></li>
          <li><a>Unread</a></li>
        </ul>
      </div>
      <div className="split-btn">
        <a className="btn" title="Archive"><img src="images/icons/archive.png" /></a>
        <a className="btn" title="Report Spam"><img src="images/icons/spam.png" /></a>
        <a className="btn" title="Delete"><img src="images/icons/delete.png" /></a>
      </div>
      <a className="btn"><img src="images/icons/refresh.png" /></a>
    </div>
