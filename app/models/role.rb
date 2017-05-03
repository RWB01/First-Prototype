# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  alias      :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Role < ApplicationRecord
  has_and_belongs_to_many :users, :join_table => 'users_roles'
end
