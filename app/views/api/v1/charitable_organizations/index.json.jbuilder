json.cache! @charitable_organizations do
  json.charitable_organizations @charitable_organizations do |charitable_organization|
    json.cache! charitable_organization do
      json.partial! charitable_organization
    end
  end
end

json.meta do
  json.result_count @charitable_organizations.length
  json.filters @filters
end
