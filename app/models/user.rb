class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy

  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy

  has_many :followers, through: :passive_relationships, source: :follower

  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy

  has_many :followings, through: :active_relationships, source: :followed

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).delete
  end

  def following?(other_user)
    findings = Relationship.find_by(follower_id: self.id, followed_id: other_user.id)
    if findings == nil
      return false
    else
      return true
    end
  end

  validates :username, presence:true

  mount_uploader :avatar, AvatarUploader

end
