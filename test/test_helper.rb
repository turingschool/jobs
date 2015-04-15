ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'minitest/emoji'

class ActiveSupport::TestCase

end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def auth_data
    OmniAuth::AuthHash.new({
      provider: 'github',
      uid: 1227440,
      credentials: {token: "1234"},
      info: {nickname: "worace", email: "horace@turing.io"}
    })
  end

  def current_user
    user_info = {github_id: auth_data.uid, github_token: auth_data.credentials.token,
                 github_name: auth_data.info.nickname, email: auth_data.info.email}
    TuringAuth::User.new(user_info)
  end

  def current_person
    Person.find_by(user_github_id: current_user.github_id)
  end

  def login_and_create_person!
    Person.create(first_name: "Pizza", last_name: "Man", user_github_id: current_user.github_id)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = auth_data
    visit login_path
  end
end
