require "spec_helper"

describe AttendancesController do
  nested_resource_should_routes 'events', 'attendances', [:create, :destroy]
  nested_resources_should_routes 'events', 'attendances', [:index, :create]
  resources_should_routes 'attendances', [:update]
end
