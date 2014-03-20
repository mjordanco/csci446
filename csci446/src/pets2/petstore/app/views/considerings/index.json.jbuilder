json.array!(@considerings) do |considering|
  json.extract! considering, :id
  json.url considering_url(considering, format: :json)
end
