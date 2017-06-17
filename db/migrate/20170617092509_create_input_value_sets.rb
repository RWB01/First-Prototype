class CreateInputValueSets < ActiveRecord::Migration[5.0]
  def change
    create_table :input_value_sets do |t|
      t.integer :difficulty

      t.timestamps
    end
  end
end
