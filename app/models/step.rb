class Step < ApplicationRecord
  belongs_to :algorithm
  has_many :variables, through: :step_variables
  has_many :step_variables
  has_and_belongs_to_many(:steps,
    :join_table => "next_steps",
    :foreign_key => "step_id",
    :association_foreign_key => "next_step_id")
end
