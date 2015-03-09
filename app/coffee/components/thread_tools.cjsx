
ThreadTools = React.createClass
  archive: (event)->
    InboxActions.archiveSelected()

  spam: (event)->
    InboxActions.spamSelected()

  delete: (event)->
    InboxActions.deleteSelected()

  render: ->
    display = if @props.someSelected then 'block' else 'none'

    <div className="split-btn" style={ display: display }>
      <a className="btn" title="Archive" onClick={@archive}><img src="images/icons/archive.png" /></a>
      <a className="btn" title="Report Spam" onClick={@spam}><img src="images/icons/spam.png" /></a>
      <a className="btn" title="Delete" onClick={@delete}><img src="images/icons/delete.png" /></a>
    </div>
