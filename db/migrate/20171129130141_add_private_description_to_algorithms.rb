class AddPrivateDescriptionToAlgorithms < ActiveRecord::Migration[5.0]
  def change
    add_column :algorithms, :private_description, :text
  end
end
