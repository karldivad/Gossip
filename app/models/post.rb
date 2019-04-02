class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validate :image_presence

  has_many :post_hash_tags
  has_many :hash_tags, through: :post_hash_tags

  def image_presence
    errors.add(:image, "can't be blank") unless image.attached?
  end
  
end