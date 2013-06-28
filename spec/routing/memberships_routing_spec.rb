require "spec_helper"

describe MembershipsController do
  nested_resource_should_routes 'groups', 'memberships', [:create, :destroy]
  nested_resources_should_routes 'groups', 'memberships', [:index, :create, :update]
end
