class DashboardsController < ApplicationController
  before_filter :require_login

  def show
      @applications = Application.active
      @dead_applications = Application.all.closed
  end
end
