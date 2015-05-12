
App.Filters.smartName = (person, fullName=true)->
  if currentUser.email == person.email
    'me'
  else if fullName
    "#{person.firstName} #{person.lastName}".trim()
  else
    person.firstName

App.Filters.nameAndEmail = (person)->
  "#{ person.firstName } #{ person.lastName } <#{ person.email }>"
