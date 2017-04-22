class AddPolymorphicRefToUser < ActiveRecord::Migration[5.0]
  def up
    change_table :users do |t|
      t.references :community, :polymorphic => true
    end
  end

  def down
    change_table :users do |t|
      t.remove_references :community, :polymorphic => true
    end
  end
end
