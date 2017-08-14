class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :body, presence: true

  validates :rating, presence: true, inclusion: { in: 1..5 }
end
