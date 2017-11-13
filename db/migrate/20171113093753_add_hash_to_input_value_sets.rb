class AddHashToInputValueSets < ActiveRecord::Migration[5.0]
  def change
    add_column :input_value_sets, :hash, :text, unique: true
  end
end
