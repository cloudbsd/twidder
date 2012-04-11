class Post < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true, length: { minimum: 6 }
  validates :content, presence: true, length: { minimum: 6 }
  validates :user_id, presence: true

  def author_name
    if self.user
      self.user.nickname
    else
      '---'
    end
  end
end
