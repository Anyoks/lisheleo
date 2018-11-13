require "rails_helper"

RSpec.describe AvailableTimesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/available_times").to route_to("available_times#index")
    end

    it "routes to #new" do
      expect(:get => "/available_times/new").to route_to("available_times#new")
    end

    it "routes to #show" do
      expect(:get => "/available_times/1").to route_to("available_times#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/available_times/1/edit").to route_to("available_times#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/available_times").to route_to("available_times#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/available_times/1").to route_to("available_times#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/available_times/1").to route_to("available_times#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/available_times/1").to route_to("available_times#destroy", :id => "1")
    end
  end
end
