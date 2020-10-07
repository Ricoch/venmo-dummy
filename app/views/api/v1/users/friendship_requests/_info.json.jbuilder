json.id request.id
json.requester do
  json.partial! 'api/v1/users/info', user: request.requester
end
json.receiver do
  json.partial! 'api/v1/users/info', user: request.receiver
end
