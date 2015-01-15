class SessionsController < ApplicationController
  def create
    user = Person.find_user_through_github_auth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to "/"
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
