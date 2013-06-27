require "spec_helper"

describe SettingsController do
  describe "routing /my/setting" do
    it "routes to #show" do
      get("/my/setting").should route_to("settings#show")
    end
    it "routes to #edit" do
      get("/my/setting/edit").should route_to("settings#edit")
    end
    it "routes to #update" do
      put("/my/setting").should route_to("settings#update")
    end
  end
end
