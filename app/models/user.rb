class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, format:  /\A\S+@\S+\z/, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8, allow_blank: true }
  validates :username, presence: true, format: /\A\w+\z/, uniqueness: { case_sensitive: false }, length: { minimum: 5, allow_blank: true }
end
