class DataStructure < ApplicationRecord
	has_many :variables
	has_many :step_variables
end
