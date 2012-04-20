class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :nickname, :gravatar

  validates :name, presence: true, uniqueness: true, length: { :maximum => 20 }
  validates :nickname, presence: true

# email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
# validates :email,     :presence => true,
#                       :format => { :with => email_regex },
#                       :uniqueness => { :case_sensitive => false }

  # users are now identified with the foreign key follower_id, so we have to tell that to Rails
  has_many :followee_items, class_name: 'FollowingItem',
                            foreign_key: 'follower_id',
                            dependent: :destroy
  has_many :follower_items, class_name: 'FollowingItem',
                            foreign_key: 'followee_id',
                            dependent: :destroy
  # source: explicitly tells Rails that the source of the followees array is the set of followee ids
  has_many :followees, through: :followee_items, source: :followee
  has_many :followers, through: :follower_items, source: :follower

# has_and_belongs_to_many :groups, foreign_key: 'user_id', class_name: 'Group', join_table: 'groups_users'
  has_and_belongs_to_many :groups

  has_many :microposts,  dependent: :nullify

  has_many :microgroups, foreign_key: 'owner_id',  :dependent => :nullify

  # user <==> post relationship
  has_many :posts, dependent: :nullify
  has_many :comments, dependent: :nullify

  def feed
    Micropost.followees_by(self)
  end

  def following?(other_user)
    self.followee_items.find_by_followee_id(other_user.id)
  end

  def follow!(other_user)
    self.followee_items.create!(followee_id: other_user.id)
  end

  def unfollow!(other_user)
    self.followee_items.find_by_followee_id(other_user.id).destroy
  end

  def join!(group)
    self.groups << group
  end

  def unjoin!(group)
    self.groups.delete group
  end
end
