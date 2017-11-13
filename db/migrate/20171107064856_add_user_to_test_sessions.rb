class AddUserToTestSessions < ActiveRecord::Migration[5.0]
  def change
    add_reference :test_sessions, :user, foreign_key: true
  end
end
