class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :species
      t.string :name
      t.text :description
      t.integer :age
      t.boolean :kids
      t.string :image_url

      t.timestamps
    end
  end
end
