class CreateTestSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :test_sessions do |t|
      t.date :test_date
      t.integer :time

      t.timestamps
    end
  end
end
