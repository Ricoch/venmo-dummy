json.id entry.id
json.date entry.created_at
json.description entry.description
json.title entry.full_description

json.sender do
  json.partial! 'api/v1/users/info', user: entry.sender
end
json.receiver do
  json.partial! 'api/v1/users/info', user: entry.receiver
end
