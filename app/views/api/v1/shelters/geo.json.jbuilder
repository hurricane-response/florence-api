json.type 'FeatureCollection'
json.features @shelters do |shelter|
  json.type 'Feature'
  json.geometry do
    json.type 'Point'
    json.coordinates [shelter.longitude, shelter.latitude]
  end
  json.properties { json.partial! shelter }
end
