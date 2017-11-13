class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
  	rename_column :input_value_sets, :hash, :hash_string
  end
end
