class CreateJoinTableUserDiscipline < ActiveRecord::Migration[5.0]
  def change
    create_join_table :users, :disciplines do |t|
      # t.index [:user_id, :discipline_id]
      # t.index [:discipline_id, :user_id]
    end
  end
end
