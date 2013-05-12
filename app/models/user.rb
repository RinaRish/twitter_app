class User < ActiveRecord::Base
  has_many :tweets, dependent: :destroy
  has_many :relationships, foreign_key: "following_id", dependent: :destroy
  has_many :followers, through: :relationships
  has_many :reverse_relationships, foreign_key: "followers_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :following, through: :reverse_relationships, source: :following
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
    relationships.find_by_followers_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followers_id: other_user.id)
  end

   def unfollow!(other_user)
    relationships.find_by_followers_id(other_user.id).destroy
  end
  
end
