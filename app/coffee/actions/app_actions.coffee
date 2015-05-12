
App.Actions.AppActions = App.createActions
  showFlash: (data)->
    @dispatch 'new-flash-message',
      message: data.message
      timeout: data.timeout
