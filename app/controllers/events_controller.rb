class EventsController < ApplicationController
  before_action Filters::NestedResourcesFilter.new
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_group
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = @group.events.order('id ASC')
  end

  def show
  end

  def new
    @event = @group.events.build
  end

  def edit
  end

  def create
    @event = @group.events.build
    @event.attributes = event_params
    @event.user = current_user
    if @event.save
      redirect_to group_events_path(@group), notice: I18n.t('events.index.created')
    else
      render 'new'
    end
  end

  def update
    @event.attributes = event_params
    if @event.save
      redirect_to group_events_path(@group), notice: I18n.t('events.show.updated')
    else
      render 'edit'
    end
  end

  def destroy
    if @event.destroy
      redirect_to group_events_path(@group), notice: I18n.t('events.index.destroyed')
    else
      render 'edit'
    end
  end

  private
  def event_params
    params.require(:event).permit(
      :name, :summary, :content,
      :place_url, :place_name, :place_address, :place_map_url,
      :capacity_max, :begin_at, :end_at,
    )
  end

  def set_group
    @group = @parent
  end

  def set_event
    @event = Event.find(params[:id])
    @group = @event.group
  end
end
