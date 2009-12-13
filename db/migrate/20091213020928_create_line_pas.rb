class CreateLinePas < ActiveRecord::Migration
  def self.up
    create_table :line_pas do |t|
      t.integer :day_id
      t.float :calories
      t.string :kind
      t.time :time

      t.timestamps
    end
  end

  def self.down
    drop_table :line_pas
  end
end
