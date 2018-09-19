class Comment < ApplicationRecord
  has_ancestry
  belongs_to :user
  belongs_to :product
  has_many :ratings, as: :rateable

  scope :root, -> { where(ancestry: nil) }
  scope :children_of_root, -> (root_id) { where(ancestry: root_id.to_s) }
  

  def self.user(user_id)
    User.find(user_id)
  end
end
