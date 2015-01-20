class DashboardsController < ApplicationController
  before_filter :require_login

  def show
    unless current_person.kind_of? String
      @to_apply_applications = application_search('to_apply')
      @closed_applications = application_search('closed')
      @in_progress_applications = application_search('in_progress')
      @applied_applications = application_search('applied')
    end
  end

  def application_search(type)
    current_user.applications.where(status: type)
  end
end
