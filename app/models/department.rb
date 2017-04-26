# == Schema Information
#
# Table name: departments
#
#  id         :integer          not null, primary key
#  alias      :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Department < ApplicationRecord
  has_many :users, :as => :community
end
