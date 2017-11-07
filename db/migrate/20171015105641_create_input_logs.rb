class CreateInputLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :input_logs do |t|
      t.integer :user_id
      t.integer :input_value_set_id
      t.integer :algorithm_id
      t.integer :question_number
      t.string :wrong_data
      t.string :all_data
      t.integer :algorithm_output_data_id

      t.timestamps
    end
  end
end
