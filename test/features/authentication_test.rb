require './test/test_helper'

class Authentication < ActionDispatch::IntegrationTest

  def test_person_can_log_in_from_omniauth
    person = Person.create(:provider => "github",
                           :uid => "1",
                           :first_name => "goldfish",
                           :oauth_token => "token")
    log_in(person)
    assert page.has_content? "Your Jobs Dashboard"
  end

  def log_in(person)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      "provider" => "github",
      "uid" => person.uid,
      "info" => { "name" => person.first_name },
      "credentials" => { "token" => person.oauth_token }
      )
      visit "/auth/github/callback"
  end
end
