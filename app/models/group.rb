class Group < ActiveRecord::Base
  has_and_belongs_to_many :users, foreign_key: 'group_id', class_name: 'User', join_table: 'groups_users'
end
