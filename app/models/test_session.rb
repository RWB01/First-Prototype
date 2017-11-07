class TestSession < ApplicationRecord
	has_many :tests, :dependent => :destroy
	has_many :test_results


	def manual_tests(numbers, strings, vectors, matrixs, group, algorithm)
		temp_algorithm = Algorithm.find(algorithm)
		temp_group = Group.find(group)
		temp_value_set = InputValueSet.new(:difficulty => "5", :algorithm_id => temp_algorithm.id)
		temp_value_set.save
		#добавляем каждый из типов в сет
		if (!numbers.nil?)
			numbers.each do |key,val|
				temp_number_value = InputVariableValue.new(:value => val[:value], :variable_id => val[:id], :input_value_set_id => temp_value_set.id)
				temp_number_value.save
			end
		end

		if (!strings.nil?)
			strings.each do |key,val|
				temp_string_value = InputVariableValue.new(:value => val[:value], :variable_id => val[:id], :input_value_set_id => temp_value_set.id)
				temp_string_value.save
			end
		end

		if (!vectors.nil?)
			vectors.each do |key,val|
				temp_vector_value = InputVariableValue.new(:value => val[:value], :variable_id => val[:id], :input_value_set_id => temp_value_set.id)
				temp_vector_value.save
			end
		end

		if (!matrixs.nil?)
			matrixs.each do |key,val|
				temp_matrix_value = InputVariableValue.new(:value => val[:value], :variable_id => val[:id], :input_value_set_id => temp_value_set.id)
				temp_matrix_value.save
			end
		end

		#назначаем тест каждому студенту группы
		if (!temp_group.users.nil?)
			temp_group.users.each do |student|
				temp_test = Test.new(:test_session_id => self.id, :algorithm_id => temp_algorithm.id, :user_id => student.id, :input_value_set_id => temp_value_set.id)
				temp_test.save
			end
		end
	end

	def generate_tests(group,algorithm)
		temp_algorithm = Algorithm.find(algorithm)
		temp_group = Group.find(group)
		

		input_variables = temp_algorithm.variables.reject{|x| !x.is_input}

		prng = Random.new
		
		if (!temp_group.users.nil? && !input_variables.nil?)
			temp_group.users.each do |student|
				temp_value_set = InputValueSet.new(:difficulty => "5", :algorithm_id => temp_algorithm.id)
				temp_value_set.save
				input_variables.each do |variable|
					
					if (variable.get_data_structure_type == :NUMBER)
						limit = variable.get_number_limitation
						temp_number = prng.rand(limit[:min_value]..limit[:max_value])
						temp_value = InputVariableValue.new(:value => temp_number, :variable_id => variable.id, :input_value_set_id => temp_value_set.id)
						temp_value.save
					end

					if (variable.get_data_structure_type == :STRING)
						limit = variable.get_string_limitation
						length = prng.rand(limit[:min_length]..limit[:max_length])

						o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
						temp_string = (0...length).map { o[rand(o.length)] }.join

						temp_value = InputVariableValue.new(:value => temp_string, :variable_id => variable.id, :input_value_set_id => temp_value_set.id)
						temp_value.save
					end

					if (variable.get_data_structure_type == :VECTOR)
						#здесь нужно будет сделать рандомизатор длины вектора
						limit = variable.get_vector_limitation
						temp_vector = "[";
						limit[:columns].times do |i|
							if (i != 0)
								temp_vector << ","
							end
							temp_vector << prng.rand(limit[:min_value]..limit[:max_value]).to_s
						end
						temp_vector << "]"

						temp_value = InputVariableValue.new(:value => temp_vector, :variable_id => variable.id, :input_value_set_id => temp_value_set.id)
						temp_value.save
					end

					if (variable.get_data_structure_type == :MATRIX)
						#здесь нужно будет сделать рандомизатор размера матрицы
						limit = variable.get_matrix_limitation
						temp_matrix = "["
						limit[:rows].times do |i|
							temp_matrix << "["
							limit[:columns].times do |j|
								if (j != 0)
									temp_matrix << ","
								end
								temp_matrix << prng.rand(limit[:min_value]..limit[:max_value]).to_s
							end
							temp_matrix << "]"
						end
						temp_matrix << "]"

						temp_value = InputVariableValue.new(:value => temp_matrix, :variable_id => variable.id, :input_value_set_id => temp_value_set.id)
						temp_value.save
					end
				end	
			temp_test = Test.new(:test_session_id => self.id, :algorithm_id => temp_algorithm.id, :user_id => student.id, :input_value_set_id => temp_value_set.id)
			temp_test.save
			end
		end
	end

	def get_algorithm_by_user(user_id)
		algorithm_id = nil

		tests.each do |test|
			if test.user_id == user_id
				algorithm_id = test.algorithm_id
			end
		end

		if algorithm_id != nil
			algorithm = Algorithm.find algorithm_id
		end

		return algorithm
	end

	def get_result_by_user_id(user_id)
		result = nil

		test_results.each do |test_result|
			if test_result.user_id == user_id
				result = test_result
			end
		end

		return result
	end
end
