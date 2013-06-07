class Post < ActiveRecord::Base
  validates_presence_of :content
  belongs_to :group
  belongs_to :user

  after_create :post_to_pusher

  private
  def post_to_pusher
    Pusher["presence-group_posts_#{self.group_id}"].trigger_async('post', id: self.id) unless Rails.env.test?
  end
end
