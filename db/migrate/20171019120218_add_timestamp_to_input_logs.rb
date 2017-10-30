class AddTimestampToInputLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :input_logs, :timestamp, :integer
  end
end
