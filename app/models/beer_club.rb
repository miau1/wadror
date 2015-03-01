class BeerClub < ActiveRecord::Base
  has_many :memberships
  has_many :members, through: :memberships, source: :user

  def onkojasen(user)
    apu = 0
    memberships.each do |m|
      if m.user.id == user.id and m.beer_club.id == id
        apu = apu + 1
      end
    end
    if apu == 1
      return true
    else
      return false
    end
  end
end
