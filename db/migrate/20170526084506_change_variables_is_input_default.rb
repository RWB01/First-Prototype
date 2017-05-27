class ChangeVariablesIsInputDefault < ActiveRecord::Migration[5.0]
  def change
  	change_column_default :variables, :is_input, false
  end
end
