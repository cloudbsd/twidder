class GroupsUsers < ActiveRecord::Base
# attr_accessible :group_id
# attr_accessible :user_id

  validates :user_id, presence: true
  validates :group_id, presence: true

  belongs_to :user
  belongs_to :group
end
