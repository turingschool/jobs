class DashboardsController < ApplicationController
  before_filter :require_login

  def show
    @applications = current_person.applications.active
    @dead_applications = current_person.applications.dead
  end
end
