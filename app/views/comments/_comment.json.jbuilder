json.extract! comment, :id, :body, :rating, :user_id, :reply_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
