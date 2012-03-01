class AddGmapsToAnnouncements < ActiveRecord::Migration
  def self.up
    add_column :announcements, :gmaps, :boolean
  end

  def self.down
    remove_column :announcements, :gmaps
  end
end
