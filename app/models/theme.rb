class Theme < ApplicationRecord
  belongs_to :discipline
  validates :title, presence: true, uniqueness: true, length: {in: 1..255}
end
