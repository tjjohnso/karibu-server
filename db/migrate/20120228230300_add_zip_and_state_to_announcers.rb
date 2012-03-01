class AddZipAndStateToAnnouncers < ActiveRecord::Migration
  def self.up
    add_column :announcers, :zip, :string
    add_column :announcers, :state, :string
  end

  def self.down
    remove_column :announcers, :state
    remove_column :announcers, :zip
  end
end
