class CommentBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment, current_user)
    ActionCable.server.broadcast 'room_channel', comment: render_comment(comment, current_user), ancestry:comment.ancestry, flag: 'create', current_user_id: current_user.id, comment_id: comment.id
  end

  private
  def render_comment(comment, current_user)
    if current_user == comment.user
      ApplicationController.renderer.render(partial: 'comments/boradcast_comment.html',
                                            locals: { root: comment, current_user: current_user })
    else
      ApplicationController.renderer.render(partial: 'comments/user_comment.html',
                                            locals: { root: comment, current_user: current_user })
    end
  end
end
