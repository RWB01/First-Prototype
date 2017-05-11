class CreateThemes < ActiveRecord::Migration[5.0]
  def change
    create_table :themes do |t|
      t.string :title
      t.references :discipline, foreign_key: true

      t.timestamps
    end
  end
end
