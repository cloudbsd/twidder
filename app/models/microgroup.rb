class Microgroup < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: { :maximum => 50 }

  belongs_to :owner, class_name: 'User'
  belongs_to :group
end
