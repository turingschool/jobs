require "./test/test_helper"

class Dashboard < ActionDispatch::IntegrationTest
  def test_it_filters_by_status_in_columns
    user = create(:person)
    create(:application, person_id: user.id)
    create(:application, status: "applied",
    company: "quickleft",
    person_id: user.id)

    page.set_rack_session(user_id: user.id)
    visit dashboard_path

    within(".applied") do
      assert page.has_content? "quickleft"
      refute page.has_content? "Google"
    end

    within(".to_apply") do
      assert page.has_content? "Google"
      refute page.has_content? "quickleft"
    end
  end
end
