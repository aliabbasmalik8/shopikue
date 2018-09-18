class CommentDeleteBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment_id)
    ActionCable.server.broadcast 'room_channel', comment_id: comment_id, flag: 'destroy'
  end
end
