class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :rateable, polymorphic: true

  after_save :broadcast_avg

  def broadcast_avg
    # @product = Product.find(rateable_id)
    avg_rating = Product.find(rateable_id).ratings.average(:rate).to_i
    puts "****" * 100
    puts @product
    puts avg_rating
    RatingBroadcastJob.perform_later avg_rating, rateable_id
  end
end
