class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?
  helper_method :current_user

  after_filter :log_session

  def log_session
    Rails.logger.info("Session: #{session.keys}, #{session.values}")
  end

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    @current_user ||= Person.find(session[:user_id]) if session[:user_id]
  end

  def current_person
    @current_person ||= find_or_create_person
  end

  private

  def find_or_create_person
    Person.find_by(uid: current_user.uid)
  end

  def require_login
    redirect_to root_path unless current_user
  end
end
