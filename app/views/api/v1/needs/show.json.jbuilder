json.ignore_nil!
json.need do
  json.cache! @need do
    json.partial! @need unless @need.nil?
  end
end

json.meta do
  json.success @success
  json.msg @msg
end
