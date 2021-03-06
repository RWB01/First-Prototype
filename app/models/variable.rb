class Variable < ApplicationRecord
  belongs_to :algorithm
  belongs_to :data_structure
  has_many :steps, through: :step_variables
  has_many :step_variables

  def get_data_structure_type
    data_structure.alias.to_sym
  end

  def get_matrix_limitation

    dimension = limitation.to_s.split("-",2)[0]
    value_limitation = limitation.to_s.split("-",2)[1]

    rows, columns = dimension.scan /\d+/

    min_value = value_limitation.split("x",2)[0]
    max_value = value_limitation.split("x",2)[1]

    {
      :rows => rows.to_i,
      :columns => columns.to_i,
      :min_value => min_value.to_i,
      :max_value => max_value.to_i,
      :name => name
    }

  end
 
  # DRY - TODO

  def get_vector_limitation

     dimension = limitation.to_s.split("-",2)[0]
     value_limitation = limitation.to_s.split("-",2)[1]

     rows, columns = dimension.scan /\d+/

     min_value = value_limitation.split("x",2)[0]
     max_value = value_limitation.split("x",2)[1]

     {
       :rows => rows.to_i,
       :columns => columns.to_i,
       :min_value => min_value.to_i,
       :max_value => max_value.to_i,
       :name => name
     }

   end

  def get_string_limitation

    min_length, max_length = limitation.to_s.scan /\d+/

    {
        :min_length => min_length.to_i,
        :max_length => max_length.to_i,
        :name => name
    }

  end

  def get_number_limitation

     min_value = limitation.to_s.split("x",2)[0]
     max_value = limitation.to_s.split("x",2)[1]

     {
             :min_value => min_value.to_i,
             :max_value => max_value.to_i,
             :name => name
     }

  end

end
