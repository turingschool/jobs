class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  Deject self, :user_repository
  include Turing::UserAuthentication
end
