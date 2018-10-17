require "rails_helper"

RSpec.describe SmsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/sms").to route_to("sms#index")
    end

    it "routes to #new" do
      expect(:get => "/sms/new").to route_to("sms#new")
    end

    it "routes to #show" do
      expect(:get => "/sms/1").to route_to("sms#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sms/1/edit").to route_to("sms#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/sms").to route_to("sms#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/sms/1").to route_to("sms#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/sms/1").to route_to("sms#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sms/1").to route_to("sms#destroy", :id => "1")
    end
  end
end
