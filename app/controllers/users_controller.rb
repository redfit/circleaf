class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id] || current_user.try(:id))
  end

  private
  def set_user
    @user = User.find(current_user.id)
  end
end
