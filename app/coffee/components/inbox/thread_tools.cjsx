
{ InboxActions } = App.Actions

App.Components.ThreadTools = React.createClass
  archive: (event)->
    InboxActions.archiveSelected()

  spam: (event)->
    InboxActions.spamSelected()

  delete: (event)->
    InboxActions.deleteSelected()

  render: ->
    { Icon } = App.Components

    display = if @props.someSelected then 'block' else 'none'

    <div className="split-btn" style={ display: display }>
      <a className="btn" title="Archive" onClick={@archive}><Icon name='archive' /></a>
      <a className="btn" title="Report Spam" onClick={@spam}><Icon name='spam' /></a>
      <a className="btn" title="Delete" onClick={@delete}><Icon name='delete' /></a>
    </div>
