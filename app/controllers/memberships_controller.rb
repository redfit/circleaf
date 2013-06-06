class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def create
    @group.join(current_user)
    redirect_to group_path(@group), notice: t('memberships.create.created')
  end

  def destroy
    @group.leave(current_user)
    redirect_to group_path(@group), notice: t('memberships.destroy.destroyed')
  end

  private
  def set_group
    @group = Group.find(params[:group_id])
  end 
end
