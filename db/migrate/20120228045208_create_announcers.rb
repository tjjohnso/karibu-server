class CreateAnnouncers < ActiveRecord::Migration
  def self.up
    create_table :announcers do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :country
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end

  def self.down
    drop_table :announcers
  end
end
