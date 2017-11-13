class AddDisciplineToTestSessions < ActiveRecord::Migration[5.0]
  def change
    add_reference :test_sessions, :discipline, foreign_key: true
  end
end
