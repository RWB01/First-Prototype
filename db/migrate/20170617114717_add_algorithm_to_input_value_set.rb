class AddAlgorithmToInputValueSet < ActiveRecord::Migration[5.0]
  def change
    add_reference :input_value_sets, :algorithm, foreign_key: true
  end
end
