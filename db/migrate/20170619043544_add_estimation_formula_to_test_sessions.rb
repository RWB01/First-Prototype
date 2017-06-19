class AddEstimationFormulaToTestSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :test_sessions, :estimation_formula, :string
  end
end
