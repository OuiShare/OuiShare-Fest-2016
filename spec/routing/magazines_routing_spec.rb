require "spec_helper"

describe MagazinesController do
  describe "routing" do

    it "routes to #index" do
      get("/magazines").should route_to("magazines#index")
    end

    it "routes to #new" do
      get("/magazines/new").should route_to("magazines#new")
    end

    it "routes to #show" do
      get("/magazines/1").should route_to("magazines#show", :id => "1")
    end

    it "routes to #edit" do
      get("/magazines/1/edit").should route_to("magazines#edit", :id => "1")
    end

    it "routes to #create" do
      post("/magazines").should route_to("magazines#create")
    end

    it "routes to #update" do
      put("/magazines/1").should route_to("magazines#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/magazines/1").should route_to("magazines#destroy", :id => "1")
    end

  end
end
