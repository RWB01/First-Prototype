class InputValueSet < ApplicationRecord
	has_many :input_variable_values
	has_many :tests
	belongs_to :algorithm
end
