require 'rails_helper'

RSpec.describe "Sms", type: :request do
  describe "GET /sms" do
    it "works! (now write some real specs)" do
      get sms_path
      expect(response).to have_http_status(200)
    end
  end
end
