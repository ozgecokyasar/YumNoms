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
  validates :image, {presence: true}

  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address? }



  def self.search(search)
    if search
      where("address ILIKE ? OR city ILIKE ? OR country ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
    else
      all
    end
  end

  def full_address
    "#{address}, #{city}, #{postcode}, #{country}"
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


filterrific(
  default_filter_params: { sorted_by: 'created_at_desc' },
  available_filters: [
    :sorted_by,
    :search_query,
    :category_id
  ]
)

# ActiveRecord association declarations

# Scope definitions. We implement all Filterrific filters through ActiveRecord
# scopes. In this example we omit the implementation of the scopes for brevity.
# Please see 'Scope patterns' for scope implementation details.
scope :search_query, lambda { |query|

}
scope :sorted_by, lambda { |sort_key|

}
scope :with_country_id, lambda { |country_ids|

}
scope :with_created_at_gte, lambda { |ref_date|

}

# This method provides select options for the `sorted_by` filter select input.
# It is called in the controller as part of `initialize_filterrific`.
def self.options_for_sorted_by
  [
    ['Price', 'price_asc'],
    ['Category', 'category_name_asc']

  ]
end



end
