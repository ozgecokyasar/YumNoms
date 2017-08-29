class User < ApplicationRecord
  has_secure_password
  has_many :favourites, dependent: :destroy
  has_many :faved_posts, through: :favourites, source: :post

  has_many :posts, dependent: :nullify
  has_many :comments, dependent: :nullify


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX, unless: :from_omniauth?

  validates :first_name, :last_name, presence: true
  before_create :generate_api_key

serialize :oauth_raw_data

  before_validation :titleize_name

  def self.create_from_omniauth(omniauth_data)
    full_name = omniauth_data["info"]["name"].split
    User.create(
      uid: omniauth_data["uid"],
      provider: omniauth_data["provider"],
      email: omniauth_data["info"]["email"],
      first_name: full_name.first,
      last_name: full_name.last,
      oauth_token: omniauth_data["credentials"]["token"],
      oauth_secret: omniauth_data["credentials"]["secret"],
      oauth_raw_data: omniauth_data,
      password: SecureRandom.hex(32)
    )
  end

  def update_oauth_credentials(omniauth_data)
     token = omniauth_data["credentials"]["token"]
     secret = omniauth_data["credentials"]["secret"]

     if oauth_token != token || oauth_secret != secret
       self.update oauth_token: token, oauth_secret: secret
     end
   end

   def self.find_by_omniauth(omniauth_data)
      User.find_by(provider: omniauth_data["provider"], uid: omniauth_data["uid"])
    end

  def from_omniauth?
    uid.present? && provider.present?
  end


  def full_name
    "#{first_name} #{last_name}"
  end

  def titleize_name
      self.name = name.titleize 
    end
end
