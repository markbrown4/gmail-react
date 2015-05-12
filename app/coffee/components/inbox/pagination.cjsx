
{ InboxActions } = App.Actions

App.Components.Pagination = React.createClass
  nextPage: (event)->
    InboxActions.nextPage()

  previousPage: (event)->
    InboxActions.previousPage()

  render: ->
    { Icon } = App.Components

    <div className="paging">
      <strong>{@props.from}-{@props.to}</strong>
      <span> of </span>
      <strong>{@props.count}</strong>
      <div className="split-btn">
        <a className="btn btn-mini" title="Previous" onClick={@previousPage}>
          <Icon name='prev' />
        </a>
        <a className="btn btn-mini" title="Next" onClick={@nextPage}>
          <Icon name='next' />
        </a>
      </div>
    </div>
