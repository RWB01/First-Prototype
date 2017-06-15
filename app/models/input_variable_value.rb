class InputVariableValue < ApplicationRecord
  belongs_to :variable
  has_and_belongs_to_many :tests, :join_table => 'input_variable_values_tests'
end
