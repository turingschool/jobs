require "./test/test_helper"

class ApplicationTest < ActiveSupport::TestCase
  def test_it_doesnt_allow_status_other_than_the_4
    application1 = Application.new(status: "to-apply")
    application2 = Application.new(status: "mine_in_progress")

    assert_equal false, application1.valid?
    assert_equal false, application2.valid?
  end

  def test_it_returns_applications_with_different_statuses
    application1 = create(:application, status: "to_apply")
    application2 = create(:application, status: "in_progress")
    application3 = create(:application, status: "applied")
    application4 = create(:application, status: "closed")

    assert_equal application1, Application.application_search("to_apply").first
    assert_equal application2, Application.application_search("in_progress").first
    assert_equal application3, Application.application_search("applied").first
    assert_equal application4, Application.application_search("closed").first
  end
end
