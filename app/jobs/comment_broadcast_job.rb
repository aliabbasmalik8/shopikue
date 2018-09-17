class CommentBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment,current_user)
    ActionCable.server.broadcast 'room_channel', comment: render_comment(comment, current_user), ancestry:comment.ancestry
  end

  private
  def render_comment(comment, current_user)
    ApplicationController.renderer.render(partial: 'comments/comment_card_for_parent.html',locals: {root: comment, current_user: current_user})
  end
end
