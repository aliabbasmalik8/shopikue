# frozen_string_literal: true

# User model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum role: [:buyer, :moderator, :admin]

  has_many :comments
  has_many :orders
  has_many :ratings
  has_many :images, as: :imageable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  def image
    if images.any?
      images.first.image
    else
      'logo.png'
    end
  end
end
