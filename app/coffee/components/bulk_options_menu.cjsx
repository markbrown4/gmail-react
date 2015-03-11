
@BulkOptionsMenu = React.createClass
  getInitialState: ->
    open: false

  toggleMenu: (event)->
    @setState open: !@state.open

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
    checkBoxClasses = React.addons.classSet
      'all-selected': @props.allSelected
      'some-selected': @props.someSelected

    menuClasses = React.addons.classSet
      active: @state.open

    <div className={"drop-down btn " + menuClasses} onClick={@toggleMenu}>
      <a className={"check " + checkBoxClasses} onClick={@bulkToggleSelected}></a>
      <Icon name='down' />
      <ul>
        <li><a onClick={@selectAll}>All</a></li>
        <li><a onClick={@selectNone}>None</a></li>
        <li><a onClick={@selectRead}>Read</a></li>
        <li><a onClick={@selectUnread}>Unread</a></li>
      </ul>
    </div>
