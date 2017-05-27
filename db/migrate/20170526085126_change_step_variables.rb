class ChangeStepVariables < ActiveRecord::Migration[5.0]
  def change
  	remove_reference :step_variables, :data_structure
  	remove_columns :step_variables, :alias, :name, :limitation
  	add_reference :step_variables, :variable
  end
end
