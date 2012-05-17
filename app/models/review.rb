class Review < ActiveRecord::Base
  validates :file, presence: true
  validates :line, presence: true

  belongs_to :user
  belongs_to :project
  has_many :votes, dependent: :destroy
  has_many :voted_users, through: :votes, source: :user

  default_scope :order => 'reviews.created_at DESC'

# scope :followees_by, lambda { |user, project, file, line|
#   followee_ids = %(SELECT followee_id FROM following_items WHERE follower_id = :user_id)
#   where("project_id IS :project_id AND (user_id IN (#{followee_ids}) OR user_id = :user_id)",
#         { user_id: user, project_id: project, file: file, line: line })
# }

  scope :reviews_by_file, lambda { |project, file|
    where("project_id IS :project_id AND file = :file",
          { project_id: project, file: file })
  }

  scope :reviews_by_file_and_user, lambda { |user, project, file|
    where("project_id IS :project_id AND user_id = :user_id AND file = :file",
          { user_id: user, project_id: project, file: file })
  }

  scope :reviews_by_line, lambda { |project, file, line|
    where("project_id IS :project_id AND file = :file AND line = :line",
          { project_id: project, file: file, line: line })
  }

  scope :reviews_by_line_and_user, lambda { |user, project, file, line|
    where("project_id IS :project_id AND user_id = :user_id AND file = :file AND line = :line",
          { user_id: user, project_id: project, file: file, line: line })
  }

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
