
@Dispatcher =
  register: (events)->
    for eventName, callback of events
      @bind eventName, callback

MicroEvent.mixin(Dispatcher)
