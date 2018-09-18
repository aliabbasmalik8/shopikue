class CommentUpdateBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment)
    ActionCable.server.broadcast 'room_channel', comment: comment.body , comment_id: comment.id, flag: 'update'
  end
end
