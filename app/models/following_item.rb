class FollowingItem < ActiveRecord::Base
  attr_accessible :followee_id

  validates :follower_id, presence: true
  validates :followee_id, presence: true

  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'
end
