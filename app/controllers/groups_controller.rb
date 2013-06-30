class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = Group.where(privacy_scope: :public).order('id ASC').page(params[:page]).per(10)
  end

  def show
    @latest_event = @group.events.where('begin_at >= ?', Time.current).order(:begin_at).last
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    if @group.save
      redirect_to groups_path, notice: I18n.t('groups.index.created')
    else
      render 'new'
    end
  end

  def update
    @group.attributes = group_params
    if @group.save
      redirect_to group_path(@group), notice: I18n.t('groups.show.updated')
    else
      render 'edit'
    end
  end

  def destroy
    if @group.destroy
      redirect_to groups_path, notice: I18n.t('groups.index.destroyed')
    else
      redirect_to groups_path, notice: I18n.t('groups.index.destroyed_error')
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, :content, :privacy_scope)
  end

  def set_group
    @group = Group.find(params[:id])
    authorize_action_for @group
  end
end
