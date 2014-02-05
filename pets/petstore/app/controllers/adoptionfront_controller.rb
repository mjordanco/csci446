class AdoptionfrontController < ApplicationController
  def index
  	@pets = Pet.all
  end
end
