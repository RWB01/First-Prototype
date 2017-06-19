class Algorithm < ApplicationRecord
  belongs_to :theme
  has_many :variables, :dependent => :delete_all
  has_many :steps, :dependent => :delete_all
  has_many :tests, :dependent => :delete_all
  has_many :input_value_sets, :dependent => :delete_all
  has_attached_file :code
  validates_attachment :code, presence: true,
  content_type: { content_type: ["text/plain", "application/octet-stream", "text/x-java-source"] }

  def code_contents(path = 'tmp/tmp.any')
    code.copy_to_local_file :original, path
    File.open(path).read
  end

  def modify_code
    directory_path = 'public/system/modified_algorithms/'+ self.id.to_s + '_' + self.title.to_s
    #папка modified algorithms уже должна быть создана
    Dir.mkdir(directory_path) unless Dir.exist?(directory_path)

    file_path = 'public/system/modified_algorithms/'+ self.id.to_s + '_' + self.title.to_s + '/' + self.code_file_name.to_s
    temp_code = self.code_contents.split("//end of variables descriptions")
    code_array = temp_code[-1].strip.split("\n")

    import = "import com.public.java-packages.AlgorithmData;"
    code_array.insert(0,import)

    #ищем на какой строчке начинается main
    i = 0
    main_line = 2
    code_array.each do |code_string|
      if code_string.include? "main(String[] args)"
         main_line = i+1
         break
      end
      i += 1
    end
    
    class_algorithm_data_variable = "AlgorithmData ad;"
    code_array.insert(main_line-1,class_algorithm_data_variable)
    initialization = "ad = new AlgorithmData();"
    code_array.insert(main_line+1,initialization)
    json_parser = "ad.parseJSON(args[0]);"
    code_array.insert(main_line+2,json_parser)
    shift_count = 4

    input_variables = self.variables.reject{|x| !x.is_input}
    input_variables.each do |variable|
      variable_string = ""
      class_variable = ""
      case variable.get_data_structure_type
        when :NUMBER
          variable_string += variable.name.to_s + " = ad.getNumberFromJSON(\"" + variable.name.to_s + "\");"
          class_variable += "int " + variable.name.to_s + ";"
        when :STRING
          variable_string += variable.name.to_s + " = ad.getStringFromJSON(\"" + variable.name.to_s + "\");"
          class_variable += "String " + variable.name.to_s + ";"
        when :VECTOR
          variable_string += variable.name.to_s + " = ad.getVectorFromJSON(\"" + variable.name.to_s + "\");"
          class_variable += "int[] " + variable.name.to_s + ";"
        when :MATRIX
          variable_string += variable.name.to_s + " = ad.getMatrixFromJSON(\"" + variable.name.to_s + "\");"
          class_variable += "int[][] " + variable.name.to_s + ";"
        else
          variable_string += "//UNKNOWN_STUFF"
          class_variable = "//UNKNOWN STUFF"
      end
      code_array.insert(main_line-1,class_variable)
      code_array.insert(main_line+shift_count,variable_string)
      shift_count += 2
    end

    self.steps.each do |step|
      line = step.line_number
      step.variables.each do |variable|
        temp_store = "ad.store(" + variable.name.to_s + ",\"" + variable.name.to_s + "\");"
        code_array.insert(line+shift_count,temp_store)
        shift_count += 1
      end
      temp_print = "ad.printAllData(" + step.step_number.to_s + ");"
      code_array.insert(line+shift_count,temp_print)
      shift_count += 1
    end
    File.open(file_path, 'w') { |file| file.write(code_array.join("\n")) }
  end

  def update_input_variables input_variables
    input_variables.each do |key, val|
      temp_variable = Variable.find(val[:id])
      temp_variable.update_attribute(:is_input, val[:is_input])
      temp_variable.update_attribute(:description, val[:description])
    end
  end

  def update_steps steps
    self.steps.each do |step|
      step.destroy
    end
    if (!steps.nil?)
      steps.each do |key, val|
        temp_step = Step.new(:step_number => val[:step_number], :line_number => val[:step_line], :description => val[:description], :algorithm_id => self.id)
        temp_step.save
        if (!val[:step_variables].nil?)
          val[:step_variables].each do |step_varialbe|
            temp_variable = Variable.find(step_varialbe)
            temp_step.variables << temp_variable;
          end
        end
      end

      steps.each do |key, val|
        new_step = Step.find_by algorithm_id: self.id, step_number: val[:step_number]
        if (!val[:next_steps].nil?)
          val[:next_steps].each do |next_step_number|
            temp_next_step = Step.find_by algorithm_id: self.id, step_number: next_step_number
            new_step.steps << temp_next_step
          end
        end
      end
    end
  end

  # @return [Step]
  def get_initial_variables

    initial_steps = Array.new

    variables.each do |x|
      if x.is_input
        initial_steps.push x
      end
    end

    return initial_steps

  end

end
