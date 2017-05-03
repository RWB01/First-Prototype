class AddDisciplinesToYsers < ActiveRecord::Migration[5.0]
  def up
    change_table :disciplines do |t|
      t.belongs_to :user, index: true
    end
  end

  def down
    change_table :disciplines do |t|
      t.remove_references :user
    end
  end
end
