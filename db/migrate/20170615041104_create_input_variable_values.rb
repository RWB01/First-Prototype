class CreateInputVariableValues < ActiveRecord::Migration[5.0]
  def change
    create_table :input_variable_values do |t|
      t.string :value
      t.references :variable, foreign_key: true

      t.timestamps
    end
  end
end
