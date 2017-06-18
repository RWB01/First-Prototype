class AddInputValueSetToInputVariableValue < ActiveRecord::Migration[5.0]
  def change
    add_reference :input_variable_values, :input_value_set, foreign_key: true
  end
end
