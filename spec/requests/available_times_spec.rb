require 'rails_helper'

RSpec.describe "AvailableTimes", type: :request do
  describe "GET /available_times" do
    it "works! (now write some real specs)" do
      get available_times_path
      expect(response).to have_http_status(200)
    end
  end
end
