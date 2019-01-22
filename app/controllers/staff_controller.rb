class StaffController < ApplicationController
  def index
    @staff = Admin.all
  end

  def show
  end
end
