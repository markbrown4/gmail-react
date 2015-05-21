
App.Actions.FlashActions = App.createActions
  newMessage: (data)->
    @dispatch 'flash-new-message',
      message: data.message
      timeout: data.timeout
