class CreateDisciplines < ActiveRecord::Migration[5.0]
  def change
    create_table :disciplines do |t|
      t.string :alias
      t.string :title

      t.timestamps
    end
  end
end
