@Message = React.createClass
  getInitialState: ->
    open: false

  toggleOpen: (event)->
    @setState open: !@state.open

  render: ->
    hiddenClass = if @state.open then '' else 'hide'
    bodyHtml = if @state.open then @props.body else @props.snippet

    <li className={ 'active' if @state.open } onClick={ @toggleOpen }>
      <div className="thread-tools">
        <time>{ @props.createdAt } ({ @props.createdAt })</time>
        <div className={ 'split-btn ' + hiddenClass }>
          <a className="btn"><img src="images/icons/reply.png" /></a>
          <div className="drop-down btn btn-mini">
            <img src="images/icons/down.png" />
            <ul className="align-right">
              <li><a>Reply</a></li>
              <li><a>Reply all</a></li>
              <li><a>Forward</a></li>
            </ul>
          </div>
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
