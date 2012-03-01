class AddLocationToAnnouncement < ActiveRecord::Migration
  def self.up
    add_column :announcements, :street, :string
    add_column :announcements, :city, :string
    add_column :announcements, :country, :string
    add_column :announcements, :longitude, :float
    add_column :announcements, :latitude, :float
  end

  def self.down
    remove_column :announcements, :latitude
    remove_column :announcements, :longitude
    remove_column :announcements, :country
    remove_column :announcements, :city
    remove_column :announcements, :street
  end
end
