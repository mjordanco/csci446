
class FosteragreementController < ApplicationController
  def index
  	pet_id = params[:pet_id]
  	@pet = Pet.find pet_id
  end
end
