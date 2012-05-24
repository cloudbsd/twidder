class Post < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 6 }
  validates :content, presence: true, length: { minimum: 6 }
  validates :user, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy

  def author_name
    if self.user
      self.user.nickname
    else
      '---'
    end
  end

  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
