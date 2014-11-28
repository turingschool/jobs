class DashboardsController < ApplicationController
  def show
    @applications = Application.all
  end
end
