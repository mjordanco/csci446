class PersonPetConsideration < ActiveRecord::Base
	belongs_to :pet
	belongs_to :considering
end
