require "./test/test_helper"

class ApplicationTest < ActiveSupport::TestCase
  def test_it_has_a_selection_of_statuses
    assert_equal Array, Application.statuses.class
    assert_equal String, Application.statuses.first.class
  end

  def test_it_returns_applications_with_different_statuses
    application1 = create(:application)
    application2 = create(:application, status: "in-progress")
    application3 = create(:application, status: "applied")
    application4 = create(:application, status: "closed")

    assert_equal application1, Application.to_apply.first
    assert_equal application2, Application.in_progress.first
    assert_equal application3, Application.applied.first
    assert_equal application4, Application.closed.first
  end
end
