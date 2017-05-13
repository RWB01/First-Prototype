class CreateAlgorithms < ActiveRecord::Migration[5.0]
  def change
    create_table :algorithms do |t|
      t.string :title
      t.string :description
      t.references :theme, foreign_key: true

      t.timestamps
    end
  end
end
