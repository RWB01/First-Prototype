class AddErrorToInputLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :input_logs, :error, :boolean
  end
end
