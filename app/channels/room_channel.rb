# frozen_string_literal: true

# Room channel
class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'room_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # ActionCable.server.broadcast 'room_channel', comment: data['comment']
    if data['ancestry'].blank?
      comment = Comment.create! body: data['comment'], user_id: data['user_id'], product_id: data['product_id']
    else
      comment = Comment.create! body: data['comment'], user_id: data['user_id'], product_id: data['product_id'], ancestry: data['ancestry']
    end
    CommentBroadcastJob.perform_later comment
  end

  def update(data)
    comment = Comment.find(data['comment_id'])
    comment.update(body: data['comment'])
    CommentUpdateBroadcastJob.perform_later comment
  end

  def destroy(data)
    CommentDeleteBroadcastJob.perform_later data['comment_id']
  end
end
