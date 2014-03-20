class AdoptionfrontController < ApplicationController
  def index
  	@pets = Pet.all
  	@considering = current_consideration
  end
end
