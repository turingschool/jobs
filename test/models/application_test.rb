require "./test/test_helper"

class ApplicationTest < ActiveSupport::TestCase
  def test_it_has_a_selection_of_statuses
    assert_equal Array, Application.statuses.class
    assert_equal String, Application.statuses.first.class
  end

  def test_it_returns_applications_with_different_statuses
    # better naming / test sorting
    to_apply_to_application_a = create(:application)
    to_apply_to_application_b = create(:application)
    in_progress_application_a = create(:application, status: "in-progress")
    in_progress_application_b = create(:application, status: "in-progress")
    applied_application_a = create(:application, status: "applied")
    applied_application_b = create(:application, status: "applied")
    closed_application_a = create(:application, status: "closed")
    closed_application_b = create(:application, status: "closed")

    assert_equal to_apply_to_application_a, Application.to_apply.first
    assert_equal in_progress_application_a, Application.in_progress.first
    assert_equal applied_application_a, Application.applied.first
    assert_equal closed_application_a, Application.closed.first
  end
end
