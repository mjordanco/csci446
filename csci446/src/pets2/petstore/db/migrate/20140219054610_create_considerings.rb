class CreateConsiderings < ActiveRecord::Migration
  def change
    create_table :considerings do |t|

      t.timestamps
    end
  end
end
