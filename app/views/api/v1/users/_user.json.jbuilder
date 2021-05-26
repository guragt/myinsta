json.id user.id
json.name user.name
json.nickname user.nickname
json.email user.email
if user.provider?
  json.provider user.provider
else
  json.provider 'native'
end
