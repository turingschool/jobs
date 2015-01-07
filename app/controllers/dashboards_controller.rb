class DashboardsController < ApplicationController
  def show
    unless current_person.kind_of? String
      @applications = current_person.applications.active
      @dead_applications = current_person.applications.dead
    end
  end
end
