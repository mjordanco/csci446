class CreatePets < ActiveRecord::Migration
  def self.up
    create_table :pets do |t|
      t.string :name
      t.integer :age
      t.string :species
      t.string :breed
      t.string :image-url
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :pets
  end
end
