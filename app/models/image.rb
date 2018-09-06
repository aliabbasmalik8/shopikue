class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  mount_uploader :image, AvatarUploader

end
