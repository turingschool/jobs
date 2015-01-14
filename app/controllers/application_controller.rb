class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Deject self, :user_repository
  include Turing::UserAuthentication
  # before_action :require_login
  # before_action :require_invitation_or_admin
end
