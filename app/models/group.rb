class Group < ApplicationRecord
  has_many :users, :as => :community
end
