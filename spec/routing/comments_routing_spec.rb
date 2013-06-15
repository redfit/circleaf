require "spec_helper"

describe CommentsController do
  nested_resources_should_routes 'events', 'comments', [:create]
  resources_should_routes 'comments', [:update, :destroy]
end
