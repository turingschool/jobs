class DashboardsController < ApplicationController
  def show
    unless current_person.kind_of? String
      @applications = current_person.applications.all
    end
  end
end
