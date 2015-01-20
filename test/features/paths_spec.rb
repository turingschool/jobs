require "./test/test_helper"

class Paths < ActionDispatch::IntegrationTest
  def test_can_visit_the_root_path_without_authentication
    visit "/"
    assert page.has_content? "Login with GitHub"
  end

  def test_can_visit_the_dashboard_if_authenticated
    user = Person.create(first_name: "Aaron", last_name: "Wortham")
    page.set_rack_session(user_id: user.id)
    visit dashboard_path
    expect(current_path).to eq dashboard_path
  end
end
