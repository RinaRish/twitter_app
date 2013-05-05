class Tweet < ActiveRecord::Base
  belongs_to :user
  default_scope order: 'created_at DESC'
  attr_accessible :content
end
