class AddGmapsToAnnouncers < ActiveRecord::Migration
  def self.up
    add_column :announcers, :gmaps, :boolean
  end

  def self.down
    remove_column :announcers, :gmaps
  end
end
