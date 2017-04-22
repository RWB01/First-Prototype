class Department < ApplicationRecord
  has_many :users, :as => :community
end
