class RemoveUserRefToDiscipline < ActiveRecord::Migration[5.0]
  def change
    remove_column :disciplines, :user, :reference
  end
end
