class Group < ActiveRecord::Base
# has_and_belongs_to_many :users, foreign_key: 'group_id', class_name: 'User', join_table: 'groups_users'
  has_and_belongs_to_many :users

  has_many :microposts, dependent: :nullify
  has_one :microgroup, dependent: :nullify
  has_one :project, dependent: :nullify
end
