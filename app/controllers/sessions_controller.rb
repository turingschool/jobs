class SessionsController < ApplicationController
  def create
    person = Person.find_or_create_user_from(request.env["omniauth.auth"])
    Rails.logger.info("Created or found person: #{person.inspect}")
    session[:user_id] = person.id
    redirect_to dashboard_path
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
