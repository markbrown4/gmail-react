
{ smartDate, timeAgo } = App.Filters

App.Components.Message = React.createClass
  getInitialState: ->
    open: false

  toggleOpen: (event)->
    return if @props.last
    @setState open: !@state.open

  render: ->
    { DropDown } = App.Components

    open = @state.open or @props.last
    hiddenClass = if open then '' else 'hide'
    bodyHtml = if open then @props.body else @props.snippet

    <li className={ 'active' if open } onClick={ @toggleOpen }>
      <div className="thread-tools">
        <time>{ smartDate(@props.createdAt) } ({ timeAgo(@props.createdAt) })</time>
        <div className={ 'split-btn ' + hiddenClass }>
          <a className="btn"><img className="icon" src="images/icons/reply.png" width="13" height="12" /></a>
          <DropDown className="btn btn-mini">
            <img className="icon" src="images/icons/down.png" width="7" height="4" />
            <ul className="align-right">
              <li><a>Reply</a></li>
              <li><a>Reply all</a></li>
              <li><a>Forward</a></li>
            </ul>
          </DropDown>
        </div>
      </div>
      <img className="avatar" src={ @props.from.avatarUrl } />
      <div className="from">
        <span className="name">{ @props.from.firstName } { @props.from.lastName } </span>
        <span className={'email ' + hiddenClass}>&lt;{ @props.from.email }&gt;</span>
      </div>
      <div className={'to ' + hiddenClass}>
        to 
        <span>{
          @props.to.map(
            (person)-> person.firstName
          ).join(', ')
        }</span>
      </div>
      <div className="body" dangerouslySetInnerHTML={{__html: bodyHtml}}></div>
    </li>
