class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews, dependent: :destroy
  has_many :movie_reviews, through: :reviews, source: :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie

  validates :name, presence: true
  validates :email, presence: true, format:  /\A\S+@\S+\z/, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8, allow_blank: true }
  validates :username, presence: true, format: /\A\w+\z/, uniqueness: { case_sensitive: false }, length: { minimum: 5, allow_blank: true }

  def self.authenticate(email_or_username, password)
    user = User.find_by(email: email_or_username) || User.find_by(username: email_or_username)
    user &&user.authenticate(password)
  end
end
