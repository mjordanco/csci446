class Considering < ActiveRecord::Base
	has_many :person_pet_considerations, :dependent => :destroy
end
