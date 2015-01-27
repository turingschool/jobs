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

  def test_it_detects_when_an_application_becomes_stale
    stale_app_date = DateTime.now.utc.beginning_of_day - 5.days
    user = create(:person)
    user.applications.create(company: "Basecamp",
                             status: "applied",
                             updated_at: stale_app_date
                            )

    page.set_rack_session(user_id: user.id)
    visit dashboard_path

    assert page.has_content? "Application hasn't been updated in over 5 days"
  end
end
