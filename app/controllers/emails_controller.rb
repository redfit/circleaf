class EmailsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_user

  def show
    redirect_to edit_my_email_path
  end

  def edit
  end

  def update
    if @user.update_email params[:email]
      redirect_to edit_my_email_path, notice: t('emails.updated')
    else
      render :edit
    end
  end

  def confirmation
    if @user.confirm_email params[:hash]
      redirect_to edit_my_email_path, notice: t('emails.confirmation.complete')
    else
      redirect_to edit_my_email_path, alert: t('emails.confirmation.error')
    end
  end

  private
  def set_user
    @user = User.find(current_user.id)
  end
end
