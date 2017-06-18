class CreateTests < ActiveRecord::Migration[5.0]
  def change
    create_table :tests do |t|
      t.references :test_session, foreign_key: true
      t.references :algorithm, foreign_key: true

      t.timestamps
    end
  end
end
