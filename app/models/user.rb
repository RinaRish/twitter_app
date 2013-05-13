class User < ActiveRecord::Base
  has_many :tweets, dependent: :destroy
  has_many :relationships, foreign_key: "followers_id", dependent: :destroy
  has_many :following, through: :relationships, source: :following

  
  has_many :reverse_relationships, foreign_key: "following_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :followers
  
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  def following?(other_user)
    relationships.find_by_following_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(following_id: other_user.id)
  end

   def unfollow!(other_user)
    relationships.find_by_following_id(other_user.id).destroy
  end
  def feed
    Tweet.from_users_following_by(self)
  end
end
