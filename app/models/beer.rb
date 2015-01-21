class Beer < ActiveRecord::Base
  include Average
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def to_s
    "#{name}, panimo: #{brewery.name}"
  end
end
