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

end
