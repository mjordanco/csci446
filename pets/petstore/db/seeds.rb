# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Pet.create([{ species: 'Dog', name: 'Murphy', age: 3}, { species: 'Dog', name: 'Maggie', age: 3}, 
	{ species: 'Dog', name: 'Apollo', age: 3}, { species: 'Dog', name: 'Train', age: 3}])