class User < ApplicationRecord
  has_secure_password

  has_many :reviews, dependent: :destroy

  has_many :favorites, dependent: :destroy

  has_many :favorite_movies, through: :favorites, source: :movie

  validates :name, presence: true

  validates :email, presence: true,
                    format: { with: /\S+@\S+/ },
                    uniqueness: { case_sensitive: false }

  validates :email, length: { minimum: 10, allow_blank: true }

  def gravatar_id
    Digest::MD5.hexdigest(email.downcase)
  end
end
