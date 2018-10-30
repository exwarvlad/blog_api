class Mark < ApplicationRecord
  belongs_to :post

  validates :post, presence: true
  validates :num, inclusion: { in: (1..5).to_a,
                               message: "%{value} is not a valid size" }
end
