class CreateAnnouncements < ActiveRecord::Migration
  def self.up
    create_table :announcements do |t|
      t.integer :announcer_id
      t.string :overview
      t.text :details
      t.float :range

      t.timestamps
    end
  end

  def self.down
    drop_table :announcements
  end
end
