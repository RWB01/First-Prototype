class StepVariable < ApplicationRecord
  belongs_to :step
  belongs_to :data_structure
end
