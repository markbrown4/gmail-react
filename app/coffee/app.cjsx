
{ AppStore } = App.Stores
{ AppActions } = App.Actions
{ Route, RouteHandler, Redirect, Handler } = ReactRouter
{ Header, SubHeader, Nav, Composer, Flash, ThreadList, ThreadDetail } = App.Components

AppLayout = React.createClass
  getInitialState: ->
    AppStore.getState()

  componentDidMount: ->
    AppActions.loadCurrentUser()

    AppStore.bind 'change', @onChange

  componentWillUnmount: ->
    AppStore.unbind 'change', @onChange

  onChange: ->
    @setState AppStore.getState()

  render: ->
    unless currentUser?
      <p>Loading...</p>
    else
      <div id="wrapper">
        <Header />
        <SubHeader />
        <Nav />
        <div id="content">
          <RouteHandler />
        </div>
        <Composer />
        <Flash />
      </div>

routes = (
  <Route handler={AppLayout}>
    <Route name="threads" path="threads" handler={ThreadList} />
    <Route name="thread" path="threads/:id" handler={ThreadDetail} />
    <Redirect from="" to="threads" />
  </Route>
)

document.addEventListener "DOMContentLoaded", ->
  ReactRouter.run routes, (Handler)->
    React.render(<Handler/>, document.body)
