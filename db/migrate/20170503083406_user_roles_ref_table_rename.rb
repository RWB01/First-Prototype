class UserRolesRefTableRename < ActiveRecord::Migration[5.0]
  def change
    rename_table :user_role_ref_tables, :users_roles
  end
end
