
@BulkOptionsMenu = React.createClass
  bulkToggleSelected: (event)->
    event.stopPropagation()

    InboxActions.bulkToggleSelected()

  selectAll: (event)->
    InboxActions.selectAll()

  selectNone: (event)->
    InboxActions.selectNone()

  selectRead: (event)->
    InboxActions.selectRead()

  selectUnread: (event)->
    InboxActions.selectUnread()

  render: ->
    checkBoxClasses = classNames
      'all-selected': @props.allSelected
      'some-selected': @props.someSelected

    <DropDown className="btn">
      <a className={"check " + checkBoxClasses} onClick={@bulkToggleSelected}></a>
      <Icon name='down' />
      <ul>
        <li><a onClick={@selectAll}>All</a></li>
        <li><a onClick={@selectNone}>None</a></li>
        <li><a onClick={@selectRead}>Read</a></li>
        <li><a onClick={@selectUnread}>Unread</a></li>
      </ul>
    </DropDown>
