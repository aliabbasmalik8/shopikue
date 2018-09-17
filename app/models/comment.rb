class Comment < ApplicationRecord
  has_ancestry
  belongs_to :user
  belongs_to :product
  
  scope :root, -> { where(ancestry: nil) }
  scope :children_of_root, -> (root_id) { where(ancestry: root_id.to_s) }
  
end
