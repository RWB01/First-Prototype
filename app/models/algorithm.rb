class Algorithm < ApplicationRecord
  belongs_to :theme
  has_many :variables
  has_many :steps
  has_attached_file :code
  validates_attachment :code, presence: true,
  content_type: { content_type: ["text/plain", "application/octet-stream", "text/x-java-source"] }

  def code_contents(path = 'tmp/tmp.any')
    code.copy_to_local_file :original, path
    File.open(path).read
  end

  def update_input_variables input_variables
    input_variables.each do |key, val|
      temp_variable = Variable.find(val[:id])
      temp_variable.update_attribute(:is_input, val[:is_input])
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
