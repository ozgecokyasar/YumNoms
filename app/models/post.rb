class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user, optional: true
  belongs_to :category, optional: true

  validates :title, {presence: true, length: {maximum: 40}}
  validates :body, {presence: true}

end
