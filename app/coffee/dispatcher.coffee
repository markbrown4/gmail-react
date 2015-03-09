
callbacks = {}

@Dispatcher =
  register: (eventName, callback)->
    callbacks[eventName] = [] if !callbacks[eventName]
    callbacks[eventName].push callback

  dispatch: (eventName, payload)->
    return unless callbacks[eventName]?

    for callback in callbacks[eventName]
      callback(payload)

  registerAll: (events)->
    for eventName, callback of events
      @register eventName, callback
