class Categorization < ActiveRecord::Base
  belongs_to :announcement
  belongs_to :category
end
