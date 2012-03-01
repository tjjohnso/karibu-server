class AddZipAndStateToAnnouncements < ActiveRecord::Migration
  def self.up
    add_column :announcements, :zip, :string
    add_column :announcements, :state, :string
  end

  def self.down
    remove_column :announcements, :state
    remove_column :announcements, :zip
  end
end
