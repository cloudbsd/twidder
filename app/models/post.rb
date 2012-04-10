class Post < ActiveRecord::Base
  belongs_to :user

  def author_name
    if self.user
      self.user.nickname
    else
      '---'
    end
  end
end
