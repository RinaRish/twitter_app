class Relationship < ActiveRecord::Base
  attr_accessible :followers_id, :following_id

  belongs_to :following, class_name: "User"
  belongs_to :followers, class_name: "User"

  validates :following_id, presence: true
  validates :followers_id, presence: true
end
