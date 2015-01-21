class DashboardsController < ApplicationController
  before_filter :require_login

  def show
    unless current_person.is_a? String
      @to_apply_applications = searcher("to_apply")
      @closed_applications = searcher("closed")
      @in_progress_applications = searcher("in_progress")
      @applied_applications = searcher("applied")
    end
  end

  private
  
  def searcher(status)
    current_user.applications.application_search(status)
  end
end
