require "spec_helper"

describe AttendancesController do
  nested_resource_should_routes 'events', 'attendances', [:create, :destroy]
end
