require "./test/test_helper"

class ApplicationTest < ActiveSupport::TestCase

  def test_it_has_a_selection_of_statuses
      assert_equal Array, Application.statuses.class
      assert_equal String, Application.statuses.first.class
  end

  def test_it_returns_applications_with_different_statuses
    application1 = create(:application)
    application2 = create(:application, status: "in-progress")
  end

end
