class User < ActiveRecord::Base
  include Average

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships

  validates :username, uniqueness: true,
 		       length: { minimum: 3, maximum: 15}

  validates :password, length: { minimum: 4},
      format: { with: /\d+/, message: "must contain at least one digit"}

  validates :password, format: { with: /[A-Z]+/, message: "must contain at least one upper case letter" }

  def count_ratings
    return ratings.count
  end
end
