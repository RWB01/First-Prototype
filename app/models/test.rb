class Test < ApplicationRecord
  belongs_to :test_session
  has_one :algorithm
  has_one :input_value_set
  has_one :user
end
