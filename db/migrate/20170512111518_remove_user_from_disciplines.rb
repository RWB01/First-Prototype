class RemoveUserFromDisciplines < ActiveRecord::Migration[5.0]
  def change
    remove_reference :disciplines, :user, foreign_key: true
  end
end
