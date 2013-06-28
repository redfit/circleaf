require "spec_helper"

describe EmailsController do
  describe "routing /my/email" do
    it "routes to #show" do
      get("/my/email").should route_to("emails#show")
    end
    it "routes to #edit" do
      get("/my/email/edit").should route_to("emails#edit")
    end
    it "routes to #update" do
      put("/my/email").should route_to("emails#update")
    end
    it "routes to #confirmation" do
      get("/my/email/confirmation/1e9de0fc008710a55431490febcf6208e827e324").should route_to("emails#confirmation", hash: '1e9de0fc008710a55431490febcf6208e827e324')
    end
  end
end
