class AttendancesController < ApplicationController
  before_action Filters::NestedResourcesFilter.new
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_event

  def index
    @attendances = @event.attendances.all
  end

  def create
    @event.join(current_user)
    redirect_to event_path(@event)
  end

  def update
    @attendance = Attendance.find(params[:id])
    @attendance.attributes = attendances_params
    @attendance.save
    redirect_to event_attendances_path(@attendance.event)
  end

  def destroy
    @event.leave(current_user)
    redirect_to event_path(@event)
  end

  private
  def attendances_params
    params.require(:attendance).permit(:status)
  end

  def set_event
    @event = @parent
  end
end
