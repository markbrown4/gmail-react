
{ CurrentUserResource } = App.Resources

App.Actions.AppActions = App.createActions
  loadCurrentUser: ->
    @dispatch 'current-user-load'
    CurrentUserResource.query().then (data)=>
      @dispatch 'current-user-load-success', data
    , (data)=>
      @dispatch 'current-user-load-error', data

  switchAccount: (account)->
    @dispatch 'switch-account', account

App.Actions.FlashActions = App.createActions
  newMessage: (data)->
    @dispatch 'flash-new-message',
      message: data.message
      timeout: data.timeout
