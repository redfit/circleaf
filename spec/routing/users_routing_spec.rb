require "spec_helper"

describe UsersController do
  resources_should_routes 'users', [:show]

  describe "routing /my/users" do
    it "routes to #destroy" do
      delete("/my").should route_to("users#destroy")
    end
    it "routes to #edit" do
      get("/my/edit").should route_to("users#edit")
    end
    it "routes to #update" do
      put("/my").should route_to("users#update")
    end
    it "routes to #show" do
      get("/my").should route_to("users#show")
    end
  end
end
