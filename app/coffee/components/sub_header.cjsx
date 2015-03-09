
SubHeader = React.createClass
  refresh: ->
    InboxActions.refresh()

  render: ->
    <div id="sub-header">
      <h1 className="app-name"><span>Re</span>Mail</h1>
      <Pagination {...@props.paging} />
      <a className="btn" title="Back to Inbox" style={display:'none'}><Icon name='back' /></a>
      <BulkOptionsMenu allSelected={@props.allSelected} someSelected={@props.someSelected} />
      <ThreadTools someSelected={@props.someSelected} />
      <a className="btn" onClick={@refresh}><Icon name='back' /></a>
    </div>
