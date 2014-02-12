json.array!(@pets) do |pet|
  json.extract! pet, :id, :species, :name, :description, :age, :kids, :image_url
  json.url pet_url(pet, format: :json)
end
