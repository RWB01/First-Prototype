class CreateSteps < ActiveRecord::Migration[5.0]
  def change
    create_table :steps do |t|
      t.integer :line_number
      t.string :description
      t.integer :step_number
      t.references :algorithm, foreign_key: true

      t.timestamps
    end
  end
end
