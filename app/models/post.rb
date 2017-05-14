class Post < ApplicationRecord
  validates :title, :body, presence: true

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  belongs_to :user

  # create method to create association between post and tags, e.g. post.all_tags('Music', "Travel")
  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name).first_or_create!
    end
  end

  def all_tags
    tags.map(&:name).join(", ")
  end

  def self.tagged_with(name)
    Tag.find_by!(name: name).posts
  end

end
