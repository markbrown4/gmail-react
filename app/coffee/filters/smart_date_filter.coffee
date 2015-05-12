
App.Filters.smartDate = (date)->
  oneDayAgo = Date.now() - 86400000
  if date < oneDayAgo
    moment(date).format("MMM DD")
  else
    moment(date).format("h:mm a")
