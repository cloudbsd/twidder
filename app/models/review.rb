class Review < ActiveRecord::Base
  validates :file, presence: true
  validates :line, presence: true

  belongs_to :user
  belongs_to :project
  has_many :votes, dependent: :destroy
  has_many :voted_users, through: :votes, source: :user

  default_scope :order => 'reviews.created_at DESC'

  scope :with_project, lambda { |project| where("project_id IS :project_id", { project_id: project }) }
  scope :with_file, lambda { |file| where("file = :file", { file: file }) }
  scope :with_line, lambda { |line| where("line = :line", { line: line }) }
  scope :with_user, lambda { |user| where("user_id = :user_id", { user_id: user }) }
# scope :with_user, lambda { |user| where("user_id IS :user_id", { user_id: user }) }

  def total_points
    sum = 0
    for i in 0...votes.count do
      sum += votes[i].point
    end
    return sum

  # votes.each do |vote|
  #   str += vote.to_s
  #   sum += 1
  # end
  # return str
  # votes.count
  ##sum = 0
  ##if self.votes.any?
  ##  self.votes.each do |vote|
  ##    sum += 1#vote.point
  ##  end
  ##end
  ##sum
  # votes.to_a.sum { |vote| vote.point } if votes != nil && votes.any?
  # sum
  end
end
