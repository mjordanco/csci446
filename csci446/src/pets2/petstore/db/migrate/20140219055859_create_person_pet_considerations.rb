class CreatePersonPetConsiderations < ActiveRecord::Migration
  def change
    create_table :person_pet_considerations do |t|
      t.integer :pet_id
      t.integer :considering_id

      t.timestamps
    end
  end
end
