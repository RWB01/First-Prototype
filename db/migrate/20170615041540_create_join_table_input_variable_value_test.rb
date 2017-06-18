class CreateJoinTableInputVariableValueTest < ActiveRecord::Migration[5.0]
  def change
    create_join_table :input_variable_values, :tests do |t|
      # t.index [:input_variable_value_id, :test_id]
      # t.index [:test_id, :input_variable_value_id]
    end
  end
end
