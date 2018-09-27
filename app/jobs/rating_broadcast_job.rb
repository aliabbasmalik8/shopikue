class RatingBroadcastJob < ApplicationJob
    queue_as :default
  
    def perform(rating, product_id)
      ActionCable.server.broadcast 'rate_channel', product_rating: rating, product_id: product_id
    end
  end
  