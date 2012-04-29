class Review < ActiveRecord::Base
  validates :file, presence: true
  validates :line, presence: true

  belongs_to :user
  belongs_to :project
end
