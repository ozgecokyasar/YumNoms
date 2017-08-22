class Post < ApplicationRecord
mount_uploader :image, ImageUploader
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :favourites, dependent: :destroy

  has_many :favers, through: :favourites, source: :user
  has_many :comments, dependent: :destroy
  belongs_to :user, optional: true
  belongs_to :category, optional: true

  validates :title, {presence: true, length: {maximum: 40}}
  validates :body, {presence: true}
  validates :address, {presence: true}
  validates :city, {presence: true}
  validates :country, {presence: true}
  validates :postcode, {presence: true}
  validates :price, {presence: true}
  validates :start_time, {presence: true}
  validates :end_time, {presence: true}
  validates :category, {presence: true}

  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  def self.search(search)
    if search
      where("address ILIKE ?", "%#{search}%")
    else
      all
    end
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(value)
    self.tags=value.split(/\s*,\s*/).map do |name|
      Tag.where(name: name.downcase).first_or_create!
    end
  end

  def average_rating
    if self.comments.size > 0
        self.comments.average(:rating)
    else
        'no rating'
    end
end




end
