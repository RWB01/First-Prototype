class StepVariable < ApplicationRecord
  belongs_to :step
  belongs_to :variables
end
