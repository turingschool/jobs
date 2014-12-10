class DashboardsController < ApplicationController
  def show
    @applications = current_person.applications.all
  end
end
