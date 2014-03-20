json.array!(@person_pet_considerations) do |person_pet_consideration|
  json.extract! person_pet_consideration, :id, :pet_id, :considering_id
  json.url person_pet_consideration_url(person_pet_consideration, format: :json)
end
