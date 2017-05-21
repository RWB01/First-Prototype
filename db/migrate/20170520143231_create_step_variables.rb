class CreateStepVariables < ActiveRecord::Migration[5.0]
  def change
    create_table :step_variables do |t|
      t.string :alias
      t.string :name
      t.references :step, foreign_key: true
      t.references :data_structure, foreign_key: true

      t.timestamps
    end
  end
end
