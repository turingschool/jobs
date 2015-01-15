class SessionsController < ApplicationController
  def create
    user = Person.from_omniauth(request.env["omniauth.auth"])
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
