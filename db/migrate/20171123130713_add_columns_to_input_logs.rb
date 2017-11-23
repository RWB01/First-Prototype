class AddColumnsToInputLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :input_logs, :wrong_step_id, :integer
    add_column :input_logs, :current_step_id, :integer
    add_column :input_logs, :line_number, :integer
  end
end
