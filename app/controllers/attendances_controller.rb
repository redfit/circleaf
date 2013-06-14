class AttendancesController < ApplicationController
  before_action Filters::NestedResourcesFilter.new
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_event

  def create
    @event.join(current_user)
    redirect_to event_path(@event)
  end

  def destroy
    @event.leave(current_user)
    redirect_to event_path(@event)
  end

  private
  def set_event
    @event = @parent
  end
end
