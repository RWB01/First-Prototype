# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  alias      :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ApplicationRecord
  has_many :users, :as => :community
end
