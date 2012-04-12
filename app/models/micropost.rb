class Micropost < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user
  belongs_to :group

  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
# validates :group_id, presence: true

  default_scope :order => 'microposts.created_at DESC'

  scope :followees_by, lambda { |user|
    followee_ids = %(SELECT followee_id FROM following_items WHERE follower_id = :user_id)
    where("group_id IS :group_id AND (user_id IN (#{followee_ids}) OR user_id = :user_id)", { user_id: user, group_id: 0 })
  }

# def self.followees_by(user)
#   followee_ids = user.followee_ids
#   where("user_id in (?) OR user_id = ?", followee_ids, user)
# end
end
