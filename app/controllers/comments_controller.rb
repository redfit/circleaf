class CommentsController < ApplicationController
  before_action Filters::NestedResourcesFilter.new
  before_action :authenticate_user!
  before_action :set_comment, only: [:update, :destroy]

  def create
    @comment = @parent.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to :back, notice: t('comments.created')
    else
      redirect_to :back, alert: @comment.errors.full_messages.join('')
    end
  end
  
  def update
    if @comment.update(comment_params)
      redirect_to :back, notice: t('comments.updated')
    else
      redirect_to :back, alert: @comment.errors.full_messages.join('')
    end
  end

  def destroy
    @comment.destroy
    redirect_to :back, notice: t('comments.destroyed')
  end

  private
  def set_comment
    @comment = Comment.find params[:id]
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
