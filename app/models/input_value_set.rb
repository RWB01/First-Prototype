class InputValueSet < ApplicationRecord
	has_many :input_variable_values
	has_many :tests
	belongs_to :algorithm

	validates_uniqueness_of :hash_string

	def create_hash
		require 'base64'
		temp_values = self.input_variable_values.order(:variable_id)
		temp_string = ""

		temp_values.each do |temp_value|
			temp_string += temp_value.variable_id.to_s + temp_value.value.to_s
		end
		enc = Base64.encode64(temp_string)

		self.update_attributes(:hash_string => "enc")
	end
end
