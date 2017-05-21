class AddLimitationToStepVariables < ActiveRecord::Migration[5.0]
  def change
    add_column :step_variables, :limitation, :string
  end
end
