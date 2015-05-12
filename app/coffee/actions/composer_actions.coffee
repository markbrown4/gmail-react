
App.Actions.ComposerActions = App.createActions
  updateFromAccount: (account)->
    @dispatch 'composer-update-from-account', account
