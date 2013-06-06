require 'spec_helper.rb'
describe PostsController do
  nested_resources_should_routes 'groups', 'posts', [:index, :create]
  resources_should_routes 'posts', [:show, :update, :destroy]
end
