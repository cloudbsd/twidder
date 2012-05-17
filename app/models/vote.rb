class Vote < ActiveRecord::Base
  validates :point, presence: true

  belongs_to :user
  belongs_to :review
end
