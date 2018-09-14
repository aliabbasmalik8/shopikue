class CommentBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment)
    ActionCable.server.broadcast 'room_channel', comment: render_comment(comment)
   
  end

  private
  def render_comment(comment)
    ApplicationController.renderer.render(partial: 'comments/comment_card',locals: {root: comment})
  end
end
