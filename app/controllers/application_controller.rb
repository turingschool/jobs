class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    @current_user ||= Person.find(session[:user_id])
  end

  def current_person
    @current_person ||= find_or_create_person
  end

  private

  helper_method :current_user

  def find_or_create_person
    Person.find_by(uid: current_user.uid)
  end

  def require_login
    unless session[:user_id]
      redirect_to login_path
    end
  end
end
