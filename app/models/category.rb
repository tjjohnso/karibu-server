class Category < ActiveRecord::Base
  has_many :announcements, :through => :categorizations
  has_many :categorizations
end
