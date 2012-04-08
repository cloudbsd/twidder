class Micropost < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user
  belongs_to :group

  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  validates :group_id, presence: true
end
