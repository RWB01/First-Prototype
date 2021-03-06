# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  community_type         :string
#  community_id           :integer
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :roles, :join_table => 'users_roles'
  belongs_to :community, :polymorphic => true, optional: true
  has_and_belongs_to_many :disciplines, :join_table => 'disciplines_users'

  def has_role(role_alias)
    result = false
    roles.each do |x|
      if x.alias.to_sym == role_alias
        result = true
      end
    end

    return result
  end
  
end
