class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def index
    @memberships = @group.memberships.all
  end

  def create
    @group.join(current_user)
    redirect_to group_path(@group), notice: t('memberships.create.created')
  end

  def update
    @membership = @group.memberships.find(params[:id])
    @membership.attributes = membership_params
    @membership.save
    redirect_to group_memberships_path(params[:group_id])
  end

  def destroy
    @group.leave(current_user)
    redirect_to group_path(@group), notice: t('memberships.destroy.destroyed')
  end

  private
  def membership_params
    params.require(:membership).permit(:level)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end 
end
