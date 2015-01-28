class SessionsController < ApplicationController
  def create
    person = Person.find_or_create_user_from(request.env["omniauth.auth"])
    session[:user_id] = person.id
    redirect_to session[:return_to] || dashboard_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env["omniauth.auth"]
  end
end
