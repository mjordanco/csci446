class Pet < ActiveRecord::Base
	has_many :person_pet_considerations

	before_destroy :ensure_not_referenced_by_any_person_pet_consideration

	def ensure_not_referenced_by_any_person_pet_consideration
		if person_pet_considerations.count.zero?
			return true
		else
			errors.add(:base, 'Person Pet Consideration Present')
			return false
		end
	end
end
