class CreateLineEats < ActiveRecord::Migration
  def self.up
    create_table :line_eats do |t|
      t.integer :day_id
      t.integer :food_id
      t.float :count
      t.time :time

      t.timestamps
    end
  end

  def self.down
    drop_table :line_eats
  end
end
