class SettingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_user

  def show
    redirect_to edit_my_setting_path
  end

  def edit
  end

  def update
    @user_setting.attributes = setting_params
    if @user_setting.save
      redirect_to edit_my_setting_path, notice: t('settings.show.updated')
    else
      render :show
    end
  end

  private
  def setting_params
    params.require(:user_setting).permit(
      :mail_attend_status,
      :mail_event_comment,
      :mail_event_attendance,
      :mail_group_event,
    )
  end

  def set_user
    @user = User.find(current_user.id)
    @user_setting = @user.setting
  end
end
