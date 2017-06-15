class Discipline < ApplicationRecord
	has_many :themes
	has_many :algorithms, through: :themes
	has_and_belongs_to_many :users, :join_table => 'disciplines_users'
end
