class AddGroupToTestSessions < ActiveRecord::Migration[5.0]
  def change
    add_reference :test_sessions, :group, foreign_key: true
  end
end
