module Average
  extend ActiveSupport::Concern

  def average_rating
    if ratings.count == 0
      return 0
    elsif ratings.map(&:score).sum.to_f == 0
      return 0
    else
    (ratings.map(&:score).sum.to_f/ratings.count).round(1)
    end
  end
end
