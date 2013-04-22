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

  acts_as_followable

# has_and_belongs_to_many :groups, foreign_key: 'user_id', class_name: 'Group', join_table: 'groups_users'
  has_and_belongs_to_many :groups

  has_many :microposts,  dependent: :nullify

  has_many :microgroups, foreign_key: 'owner_id',  :dependent => :nullify
  has_many :joined_microgroups, through: :groups, source: :microgroup

  has_many :projects, foreign_key: 'owner_id',  :dependent => :nullify
  has_many :watched_projects, through: :groups, source: :project

  # user <==> post relationship
  has_many :posts, dependent: :nullify
  has_many :reviews, dependent: :nullify
  has_many :comments, dependent: :nullify

  has_many :votes, dependent: :destroy
  has_many :voted_reviews, through: :votes, source: :review

  def feed
    Micropost.followees_by(self)
  end

  def join?(group)
    self.groups.exists? group
  end

  def join!(group)
    self.groups << group
  end

  def unjoin!(group)
    self.groups.delete group
  end

  def watch?(group)
    self.watchers.exists? group
  end

  def watch!(group)
    self.watchers << group
  end

  def unwatch!(group)
    self.watchers.delete group
  end
end
