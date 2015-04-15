module Turing
  module UserAuthentication
    extend ActiveSupport::Concern

    included do
      helper_method :logged_in?
      helper_method :current_user
      helper_method :current_person
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @current_user ||= user_repository.find session[:user_id]
    end

    def current_person
      @current_person ||= find_or_create_person
    end

    private

    def require_login
      current_user
    rescue Jsl::Identity::ResourceNotFound
      requested_url = Rack::Request.new(request.env).url
      redirect_to user_repository.login_url(requested_url)
    end

    def require_invitation_or_admin
      unless current_user && (current_user.invited? || current_user.admin?)
        render text:   'An invitation is required to visit this site',
               status: :forbidden
      end
    end
  end
end
