class GroupsUsers < ActiveRecord::Base
  validates :user_id, presence: true
  validates :group_id, presence: true

  belongs_to :user
  belongs_to :group
end
