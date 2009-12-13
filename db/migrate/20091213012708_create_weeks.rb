class CreateWeeks < ActiveRecord::Migration
  def self.up
    create_table :weeks do |t|
      t.integer :user_id
      t.date :start

      t.timestamps
    end
  end

  def self.down
    drop_table :weeks
  end
end
