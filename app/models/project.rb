class Project < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: { :maximum => 50 }
  validates :path, presence: true, uniqueness: true

  belongs_to :owner, class_name: 'User'
  belongs_to :group
  has_many :reviews, dependent: :nullify

  def reviews_by_file(file)
    Review.reviews_by_file(self, file)
  end

  def reviews_by_line(file, line)
    Review.reviews_by_line(self, file, line)
  end
end
