class AddInputValueSetToTest < ActiveRecord::Migration[5.0]
  def change
    add_reference :tests, :input_value_set, foreign_key: true
  end
end
