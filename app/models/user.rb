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
  
end
