class Post < ApplicationRecord
  belongs_to :user
  has_many :mark
  accepts_nested_attributes_for :user

  validates :header, presence: true
  validates :body, presence: true
  validates :ip, presence: true
  validates :user, presence: true
end
