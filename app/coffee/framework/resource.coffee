
queryString = (obj)->
  params = []
  for key, val of obj
    params.push "#{key}=#{encodeURIComponent(val)}"

  params.join '&'

method = (action)->
  switch action
    when 'index' then 'get'
    when 'show' then 'get'
    when 'update' then 'patch'
    when 'create' then 'post'
    when 'destroy' then 'delete'

parseDates = (data, fields)->
  for field in fields
    data[field] = moment(data[field]).toDate()

  data

formatDates = (data, fields)->
  for field in fields
    data[field] = moment(data[field]).format('YYYY-MM-DD')

  data

formatDateTimes = (data, fields)->
  for field in fields
    data[field] = moment(data[field]).utc().format()

  data

Resource =
  dateFields: []
  dateTimeFields: []

  request: (action, params, id, data)->
    r = reqwest(
      url: @url(id, params)
      method: method(action)
      data: @beforeRequest(data, action)
      type: 'json'
    ).then (data)=>
      @afterResponse(data, action)

    r

  url: (id, params)->
    url = @urlRoot
    url += "/#{id}" if id?
    url += "?#{queryString(params)}" if params?

    url

  beforeRequest: (data, action)->
    return unless data?

    data = formatDates(data, @dateFields) if @dateFields.length > 0
    data = formatDateTimes(data, @dateTimeFields) if @dateTimeFields.length > 0

    data

  afterResponse: (data, action)->
    return unless data?

    data = parseDates(data, @dateFields) if @dateFields.length > 0
    data = parseDates(data, @dateTimeFields) if @dateTimeFields.length > 0

    data

  query: (params)->
    @request 'index', params

  where: (params)->
    @request 'index', params

  get: (id, params)->
    @request 'show', params, id

  update: (id, data)->
    @request 'update', null, id, data

  create: (data)->
    @request 'create', null, null, data

  destroy: (id)->
    @request 'destroy', null, id

App.createResource = (obj)->
  Object.assign(Object.create(Resource), obj)
