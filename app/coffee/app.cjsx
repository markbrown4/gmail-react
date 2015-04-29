Route = ReactRouter.Route
RouteHandler = ReactRouter.RouteHandler
Redirect = ReactRouter.Redirect

App = React.createClass
  render: ->
    <div id="wrapper">
      <Header />
      <SubHeader />
      <Nav />
      <div id="content">
        <RouteHandler />
      </div>
    </div>

routes = (
  <Route handler={App}>
    <Route name="threads" path="threads" handler={ThreadList} />
    <Route name="thread" path="threads/:id" handler={ThreadDetail} />
    <Redirect from="" to="threads" />
  </Route>
)

document.addEventListener "DOMContentLoaded", ->
  ReactRouter.run routes, (Handler)->
    React.render(<Handler/>, document.body)
