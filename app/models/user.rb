class User < ApplicationRecord
  has_many :opinions, dependent: :destroy, foreign_key: 'author_id'
  has_many :followings, dependent: :destroy, foreign_key: 'follower_id'
  has_many :inverse_followings, dependent: :destroy, class_name: 'Following', foreign_key: 'followed_id'
  has_many :followed_users, through: :followings, class_name: 'User', source: 'followed'
  has_many :followers, through: :inverse_followings, class_name: 'User', source: 'follower'
  has_one_attached :photo
  has_one_attached :cover_image

  validates :username, presence: true, length: { minimum: 2, maximum: 20 }
  validates_uniqueness_of :username, on: :create
  validates :fullname, presence: true, length: { minimum: 2, maximum: 40 }
  validates :photo, content_type: %i[png jpg jpeg],
                    dimension: { width: { min: 50, max: 500 },
                                 height: { min: 50, max: 500 }, message: 'is not given between dimension' },
                    size: { less_than: 3.megabytes, message: 'is not given between size' }
  validates :cover_image, content_type: %i[png jpg jpeg],
                          dimension: { width: { min: 200, max: 1600 },
                                       height: { min: 200, max: 1600 }, message: 'is not given between dimension' },
                          size: { less_than: 4.megabytes, message: 'is not given between size' }

  scope :all_except, ->(user) { where.not(username: user.username) }

  def follows?(user)
    followed_users.include?(user)
  end
end
