class NextSteps < ActiveRecord::Migration[5.0]
  def change
  	create_table "next_steps", :force => true, :id => false do |t|
  		t.integer "step_id", :null => false
  		t.integer "next_step_id", :null => false
	end
  end
end
