class AddIsInputToVariables < ActiveRecord::Migration[5.0]
  def change
    add_column :variables, :is_input, :boolean
  end
end
