class ApplicationController < ActionController::Base
  include TuringAuth::CurrentUser
  protect_from_forgery with: :exception

  before_action :require_login

  def current_person
    @current_person ||= find_or_create_person
  end
  helper_method :current_person

  def find_or_create_person
    Person.where(:user_github_id => current_user.github_id).first || redirect_to(new_person_path)
  end

  def require_login
    redirect_to login_path unless current_user
  end
end
