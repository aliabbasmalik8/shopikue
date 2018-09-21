class CommentBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment)
    ActionCable.server.broadcast 'room_channel', comment_id: comment.id, ancestry:comment.ancestry, flag: 'create', product_id: comment.product_id
  end
end