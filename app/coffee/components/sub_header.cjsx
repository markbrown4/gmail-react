
SubHeader = React.createClass
  getInitialState: ->
    bulkOptionsOpen: false

  bulkToggleSelected: (event)->
    event.stopPropagation()

    InboxActions.bulkToggleSelected()

  toggleBulkOptions: (event)->
    @setState bulkOptionsOpen: !@state.bulkOptionsOpen

  selectAll: (event)->
    InboxActions.selectAll()

  selectNone: (event)->
    InboxActions.selectNone()

  selectRead: (event)->
    InboxActions.selectRead()

  selectUnread: (event)->
    InboxActions.selectUnread()

  render: ->
    bulkSelectClasses = React.addons.classSet
      'all-selected': ThreadStore.allSelected()
      'some-selected': ThreadStore.someSelected()

    bulkDropDownClasses = React.addons.classSet
      'active': @state.bulkOptionsOpen

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
      <div className={"drop-down btn " + bulkDropDownClasses} onClick={@toggleBulkOptions}>
        <a className={"check " + bulkSelectClasses} onClick={@bulkToggleSelected}></a>
        <img src="images/icons/down.png" />
        <ul>
          <li><a onClick={@selectAll}>All</a></li>
          <li><a onClick={@selectNone}>None</a></li>
          <li><a onClick={@selectRead}>Read</a></li>
          <li><a onClick={@selectUnread}>Unread</a></li>
        </ul>
      </div>
      <div className="split-btn">
        <a className="btn" title="Archive"><img src="images/icons/archive.png" /></a>
        <a className="btn" title="Report Spam"><img src="images/icons/spam.png" /></a>
        <a className="btn" title="Delete"><img src="images/icons/delete.png" /></a>
      </div>
      <a className="btn"><img src="images/icons/refresh.png" /></a>
    </div>
