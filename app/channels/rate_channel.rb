class RateChannel < ApplicationCable::Channel
  def subscribed
    stream_from "rate_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    RatingBroadcastJob.perform_later data['avg_rating'], data['product_id']
  end
end
