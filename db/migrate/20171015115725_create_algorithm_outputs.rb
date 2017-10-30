class CreateAlgorithmOutputs < ActiveRecord::Migration[5.0]
  def change
    create_table :algorithm_outputs do |t|
      t.integer :algorithm_id
      t.integer :input_value_set_id
      t.string :data

      t.timestamps
    end
  end
end
