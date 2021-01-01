class User < ApplicationRecord
  before_save :format_username
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie
  
  has_secure_password

  validates :name, presence: true

  validates :password, length: { minimum: 10, allow_blank: true}

  validates :email, format: { with: /\S+@\S+/}, uniqueness: { case_sensitive: false }

  # validates :username, presence: true, format: { with: /\A[A-Z0-9]+\z/i }, uniqueness: { case_sensitive: false }

  scope :by_name, -> { order(:name) }
  scope :not_admins, -> { by_name.where(admin: false)}
  scope :admins, -> { by_name.where(admin: true)}

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

  def to_param
    username
  end

  private

    def format_username
      if username && username != ""
        self.username = username.downcase
      else
        self.username = name.parameterize + rand.to_s[2..5]
      end
    end
end
