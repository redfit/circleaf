class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_one :post, as: :postable

  after_create :create_post
  after_destroy :destroy_post

  private
  def create_post
    group_id = self.commentable.try(:group_id)
    return unless group_id
    self.post = self.user.posts.create(group_id: group_id, content: 'see comments.content')
  end

  def destroy_post
    self.post.try(:destroy)
  end
end
