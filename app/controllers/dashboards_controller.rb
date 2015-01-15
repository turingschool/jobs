class DashboardsController < ApplicationController
  def show
    unless current_person.kind_of? String
      @to_apply_applications = application_search(to_apply)
      @closed_applications = application_search(closed)
      @in_progress_applications = application_search(in_progress)
      @applied_applications = application_search(applied)
    end
  end

  def application_search(type)
    current_person.applications.status == type
  end
end
