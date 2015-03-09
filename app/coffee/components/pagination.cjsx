
Pagination = React.createClass
  nextPage: (event)->
    InboxActions.nextPage()

  previousPage: (event)->
    InboxActions.previousPage()

  render: ->
    <div className="paging">
      <strong>{@props.from}-{@props.to}</strong>
      <span> of </span>
      <strong>{@props.count}</strong>
      <div className="split-btn">
        <a className="btn btn-mini" title="Previous" onClick={@previousPage}><img src="images/icons/prev.png" /></a>
        <a className="btn btn-mini" title="Next" onClick={@nextPage}><img src="images/icons/next.png" /></a>
      </div>
    </div>
