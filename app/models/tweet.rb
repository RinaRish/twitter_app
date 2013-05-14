class Tweet < ActiveRecord::Base
  belongs_to :user
  default_scope order: 'created_at DESC'
  attr_accessible :content

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  def self.from_users_following_by(user)
    followeing_ids = "SELECT following_id FROM relationships
                         WHERE followers_id = :user_id"
    where("user_id IN (#{following_ids}) OR user_id = :user_id",
          user_id: user.id)
  end
end
