class Variable < ApplicationRecord
  belongs_to :algorithm
  belongs_to :data_structure
  has_many :steps, through: :step_variables
  has_many :step_variables
end
