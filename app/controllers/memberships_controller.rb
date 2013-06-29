class MembershipsController < ApplicationController
  before_action Filters::NestedResourcesFilter.new
  before_action :authenticate_user!
  before_action :set_group

  def index
    @memberships = @group.memberships.order('id ASC').to_a
    authorize_action_for Membership.new(group: @group)
  end

  def create
    @group.join(current_user)
    redirect_to group_path(@group), notice: t('memberships.create.created')
  end

  def update
    @membership = Membership.find(params[:id])
    authorize_action_for @membership
    @membership.attributes = membership_params
    @membership.save
    redirect_to group_memberships_path(@membership.group), notice: t('memberships.update.updated')
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
    @group = @parent
  end 
end
