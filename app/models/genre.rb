class Genre < ActiveRecord::Base
  validate :name, presence: true, uniqueness: true

  has_many :characterizations, dependent: :destroy
  has_many :movies, through: :characterizations
end
