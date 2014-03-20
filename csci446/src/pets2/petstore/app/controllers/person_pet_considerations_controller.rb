class PersonPetConsiderationsController < ApplicationController
  before_action :set_person_pet_consideration, only: [:show, :edit, :update, :destroy]

  # GET /person_pet_considerations
  # GET /person_pet_considerations.json
  def index
    @person_pet_considerations = PersonPetConsideration.all
  end

  # GET /person_pet_considerations/1
  # GET /person_pet_considerations/1.json
  def show
  end

  # GET /person_pet_considerations/new
  def new
    @person_pet_consideration = PersonPetConsideration.new
  end

  # GET /person_pet_considerations/1/edit
  def edit
  end

  # POST /person_pet_considerations
  # POST /person_pet_considerations.json
  def create
    @considering = current_consideration
    pet = Pet.find(params[:pet_id])
    current_item = @considering.person_pet_considerations.where(:pet_id => pet.id).first
    if !current_item
      @person_pet_consideration = @considering.person_pet_considerations.build(:pet => pet)

      respond_to do |format|
        if @person_pet_consideration.save
          format.html { redirect_to(adoptionfront_index_url) }
          format.js
          format.json { render action: 'show', status: :created, location: @person_pet_consideration }
        else
          format.html { render action: 'new' }
          format.json { render json: @person_pet_consideration.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.js
        format.html { redirect_to adoptionfront_index_url, flash[:notice] => 'Pet already considered.' }
      end
    end
  end

  # PATCH/PUT /person_pet_considerations/1
  # PATCH/PUT /person_pet_considerations/1.json
  def update
    respond_to do |format|
      if @person_pet_consideration.update(person_pet_consideration_params)
        format.html { redirect_to @person_pet_consideration, notice: 'Person pet consideration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @person_pet_consideration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /person_pet_considerations/1
  # DELETE /person_pet_considerations/1.json
  def destroy
    @person_pet_consideration.destroy
    respond_to do |format|
      format.html { redirect_to person_pet_considerations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person_pet_consideration
      @person_pet_consideration = PersonPetConsideration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_pet_consideration_params
      params.require(:person_pet_consideration).permit(:pet_id, :considering_id)
    end
end
