Route = ReactRouter.Route
RouteHandler = ReactRouter.RouteHandler
Redirect = ReactRouter.Redirect

App = React.createClass
  render: ->
    <RouteHandler/>

routes = (
  <Route handler={App}>
    <Route name="inbox" path="inbox" handler={Inbox} />
    <Route name="thread" path="threads/:id" handler={ThreadDetail} />
    <Redirect from="" to="inbox" />
  </Route>
)

ReactRouter.run routes, (Handler)->
  React.render(<Handler/>, document.body)
