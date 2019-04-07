class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts, dependent: :destroy

  has_one_attached :avatar
  validate :avatar_validate

   def avatar_validate
    if avatar.attached?
      if avatar.blob.byte_size > 2000000
        avatar.purge
        errors.add(:avatar, "should be less than 2MB")
      elsif !avatar.blob.content_type.starts_with?('image/')
        avatar.purge
        errors.add(:avatar, "Wrong format")
      end
    end
  end

end
