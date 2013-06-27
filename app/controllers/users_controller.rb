class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id] || current_user.try(:id))
  end

  def edit
  end

  def update
    @user.attributes = user_param
    if @user.save
      redirect_to edit_my_path, notice: t('users.edit.updated')
    else
      render :edit
    end
  end

  private
  def set_user
    @user = User.find(current_user.id)
  end

  def user_param
    params.require(:user).permit(
      :content,
    )
  end
end
