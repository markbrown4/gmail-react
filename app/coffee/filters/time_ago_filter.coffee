units = [
  { name: "second", limit: 60, inSeconds: 1 },
  { name: "minute", limit: 3600, inSeconds: 60 },
  { name: "hour", limit: 86400, inSeconds: 3600  },
  { name: "day", limit: 604800, inSeconds: 86400 },
  { name: "week", limit: 2629743, inSeconds: 604800  },
  { name: "month", limit: 31556926, inSeconds: 2629743 },
  { name: "year", limit: null, inSeconds: 31556926 }
]

App.Filters.timeAgo = (date)->
  diff = (Date.now() - date)/1000
  return "just now" if diff < 5

  for unit in units
    if diff < unit.limit || !unit.limit
      diff =  Math.floor(diff / unit.inSeconds)
      return "#{diff} #{unit.name}#{ if diff > 1 then 's' else '' } ago"
