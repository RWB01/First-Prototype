class DropInputVariableValuesTestsTable < ActiveRecord::Migration[5.0]
  def change
  	drop_table :input_variable_values_tests
  end
end
