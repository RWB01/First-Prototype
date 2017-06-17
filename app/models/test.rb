class Test < ApplicationRecord
  belongs_to :test_session
  has_one :algorithm
    has_and_belongs_to_many :input_variable_values, :join_table => 'input_variable_values_tests'
end
