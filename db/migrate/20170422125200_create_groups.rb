class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string :alias
      t.string :title

      t.timestamps
    end
  end
end
