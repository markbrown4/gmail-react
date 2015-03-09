
SubHeader = React.createClass
  refresh: ->
    InboxActions.refresh()

  render: ->
    <div id="sub-header">
      <h1 className="app-name"><span>Re</span>Mail</h1>
      <Pagination {...@props.paging} />
      <a className="btn" title="Back to Inbox" style={display:'none'}><img src="images/icons/back.png" /></a>
      <BulkOptionsMenu allSelected={@props.allSelected} someSelected={@props.someSelected} />
      <ThreadTools someSelected={@props.someSelected} />
      <a className="btn" onClick={@refresh}><img src="images/icons/refresh.png" /></a>
    </div>
