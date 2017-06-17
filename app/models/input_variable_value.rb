class InputVariableValue < ApplicationRecord
  belongs_to :variable
  belongs_to :input_value_set
end
