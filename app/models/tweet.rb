class Tweet < ActiveRecord::Base
  belongs_to :user
  default_scope order: 'created_at DESC'
  attr_accessible :content

  def self.from_users_following_by(user)
    following_user_ids = user.following_user_ids
    where("user_id IN (?) OR user_id = ?", following_user_ids, user)
  end
end
