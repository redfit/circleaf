class Post < ActiveRecord::Base
  validates_presence_of :content
  belongs_to :group
  belongs_to :user
end
