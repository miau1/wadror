class User < ActiveRecord::Base
  include Average

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  validates :username, uniqueness: true,
 		       length: { minimum: 3, maximum: 15}

  validates :password, length: { minimum: 4 }

  validates :password, format: { with: /\d.*[A-Z]|[A-Z].*\d/, message: "has to contain one number and one upper case letter" }

  def self.top(n)
    sorted_by_rating_in_desc_order = User.all.sort_by{ |u| -(u.ratings.count||0) }
    sorted_by_rating_in_desc_order.take(n)
  end

  def count_ratings
    return ratings.count
  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    best_style
  end

  def favorite_brewery
    return nil if ratings.empty?
    best_brewery
  end

  def average_score_by_style(style)
    apu = 0
    score = 0.0
    ratings.each do |r|
      if r.beer.style == style
        apu = apu + 1
        score = score + r.score
      end
    end
    return score/apu
  end

  def average_score_by_brewery(brewery)
    apu = 0
    score = 0.0
    ratings.each do |r|
      if r.beer.brewery == brewery
        apu = apu + 1
        score = score + r.score
      end
    end
    return score/apu
  end

  def rated_styles
    styles = []
    ratings.each do |r|
      if styles.include?(r.beer.style) == false
        styles.push(r.beer.style)
      end
    end
    return styles
  end

  def rated_breweries
    breweries = []
    ratings.each do |r|
      if breweries.include?(r.beer.brewery) == false
        breweries.push(r.beer.brewery)
      end
    end
    return breweries
  end

  def best_style
    scores = Hash.new
    rated_styles.each do |s|
      scores[s] = average_score_by_style(s)
    end
    return scores.sort_by{|k, v| v}.last[0]
  end

  def best_brewery
    scores = Hash.new
    rated_breweries.each do |s|
      scores[s] = average_score_by_brewery(s)
    end
    return scores.sort_by{|k, v| v}.last[0]
  end
end
