class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:index, :create]
  before_action :set_post, only: [:show, :update, :destroy]
  layout Proc.new { |controller| controller.request.xhr? ? false : nil }

  def index
    @posts = @group.posts.order('id DESC').limit(20).to_a.reverse
  end

  def show
  end

  def create
    @post = @group.posts.new(post_params)
    @post.user = current_user
    @post.save
    if request.xhr?
      head(:ok)
    else
      redirect_to group_posts_path(@group)
    end
  end

  def update
    @post.update(post_params)
    redirect_to group_posts_path(@group)
  end

  def destroy
    @group = @post.group
    @post.destroy
    if request.xhr?
      head(:ok)
    else
      redirect_to group_posts_path(@group)
    end
  end

  private
  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
