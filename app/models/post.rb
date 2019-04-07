class Post < ApplicationRecord
  after_commit :create_hash_tags, on: :create

  belongs_to :user
  has_one_attached :image
  validate :image_validate

  has_many :post_hash_tags
  has_many :hash_tags, through: :post_hash_tags

  def image_validate
    errors.add(:image, "can't be blank") unless image.attached?
    if image.attached?
      if image.blob.byte_size > 5000000
        image.purge
        errors.add(:image, "should be less than 5MB")
      elsif !image.blob.content_type.starts_with?('image/')
        image.purge
        errors.add(:image, "Wrong format")
      end
    end
  end

  def create_hash_tags
    extract_name_hash_tags.each do |name|
      hash_tags.create(name: name)
    end
  end

  def extract_name_hash_tags
    description.to_s.scan(/#\w+/).map{|name| name.gsub("#", "")}
  end
  
end