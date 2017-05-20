class Variable < ApplicationRecord
  belongs_to :algorithm
  has_one :data_structure
end
