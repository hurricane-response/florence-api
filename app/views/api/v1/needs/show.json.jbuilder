json.ignore_nil!
json.needs [@need] do |need|
  json.cache! need do
    json.partial! @need unless @need.nil?
  end
end

json.meta do
  json.success @success
  json.msg @msg
end
