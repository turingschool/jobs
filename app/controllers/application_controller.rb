class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

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

  def find_or_create_person
    Person.find_by(:uid => current_user.uid)
  end

  def require_login
    unless session[:user_id]
      redirect_to login_path
    end
  end

  def require_invitation_or_admin
    unless current_user && (current_user.invited? || current_user.admin?)
      render text:   'An invitation is required to visit this site',
             status: :forbidden
    end
  end

end
