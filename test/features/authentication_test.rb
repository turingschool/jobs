require "./test/test_helper"

class Authentication < ActionDispatch::IntegrationTest
  def test_person_can_log_in_from_omniauth
    person = create(:person)
    log_in(person)
    visit root_path

    assert page.has_content? "Log out"
  end

  def log_in(person)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      "provider" => "github",
      "uid" => person.uid,
      "info" => { "name" => person.first_name },
      "credentials" => { "token" => person.oauth_token })
    visit "/auth/github/callback"
  end

  def test_log_in_only_shows_up_if_not_logged_in
    person = create(:person)
    visit root_path

    assert page.has_content? "Log in with GitHub"

    page.set_rack_session(user_id: person.id)
    visit root_path

    refute page.has_content? "Log in with GitHub"
  end

  def test_can_visit_the_root_path_without_authentication
    visit root_path

    assert page.has_content? "Log in with GitHub"
  end

  def test_can_visit_the_dashboard_if_authenticated
    user = create(:person)
    page.set_rack_session(user_id: user.id)
    visit dashboard_path
    assert current_path, dashboard_path
  end

  def test_user_is_prompted_to_log_in_from_bookmarklet_window
    query_parameter = "google.com/jobs/1"

    visit new_application_path(uri: query_parameter)

    assert page.has_content? "Log in with GitHub"
  end
end
