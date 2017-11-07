class CreateTestResults < ActiveRecord::Migration[5.0]
  def change
    create_table :test_results do |t|
      t.integer :test_session_id
      t.integer :result
      t.string :estimation_formula
      t.integer :errors_count
      t.boolean :is_passed
      t.integer :unique_errors
      t.integer :input_value_set_id

      t.timestamps
    end
  end
end
