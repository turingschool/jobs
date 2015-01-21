require "./test/test_helper"

class Paths < ActionDispatch::IntegrationTest
  def test_can_visit_the_root_path_without_authentication
    visit "/"
    assert page.has_content? "Log in with GitHub"
  end

  def test_can_visit_the_dashboard_if_authenticated
    user = create(:person)
    page.set_rack_session(user_id: user.id)
    visit dashboard_path
    assert current_path, dashboard_path
  end
end
