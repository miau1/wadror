class Membership < ActiveRecord::Base
  has_many :users
  has_many :beer_clubs
end
