class CreateVariables < ActiveRecord::Migration[5.0]
  def change
    create_table :variables do |t|
      t.string :alias
      t.string :name
      t.string :limitation
      t.references :algorithm, foreign_key: true
      t.references :data_structure, foreign_key: true

      t.timestamps
    end
  end
end
