class AttendancesController < ApplicationController
  before_action Filters::NestedResourcesFilter.new
  before_action :authenticate_user!
  before_action :set_event

  def index
    @attendances = @event.attendances.to_a
    authorize_action_for Attendance.new(event: @event)
  end

  def create
    @event.join(current_user)
    redirect_to event_path(@event)
  end

  def update
    @attendance = Attendance.find(params[:id])
    authorize_action_for @attendance
    @attendance.attributes = attendances_params
    @attendance.save
    redirect_to event_attendances_path(@attendance.event), notice: t('attendances.update.updated')
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
