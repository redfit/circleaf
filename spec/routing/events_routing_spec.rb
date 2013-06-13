require "spec_helper"

describe EventsController do
  nested_resources_should_routes 'groups', 'events', [:index, :new, :create]
  resources_should_routes 'events', [:show, :edit, :update, :destroy]
end
