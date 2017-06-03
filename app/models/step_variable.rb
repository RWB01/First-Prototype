class StepVariable < ApplicationRecord
  belongs_to :step
  belongs_to :variable
end
