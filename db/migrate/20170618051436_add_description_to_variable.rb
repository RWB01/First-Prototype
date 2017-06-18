class AddDescriptionToVariable < ActiveRecord::Migration[5.0]
  def change
    add_column :variables, :description, :string
  end
end
