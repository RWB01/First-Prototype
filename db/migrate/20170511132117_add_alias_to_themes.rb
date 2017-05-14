class AddAliasToThemes < ActiveRecord::Migration[5.0]
  def change
    add_column :themes, :alias, :string
  end
end
