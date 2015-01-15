class DashboardsController < ApplicationController
  def show
      @applications = Application.active
      @dead_applications = Application.all.closed
  end
end
