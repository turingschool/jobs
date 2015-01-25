require "./test/test_helper"

class ApplicationTest < ActiveSupport::TestCase
  def test_it_doesnt_allow_status_other_than_the_4
    application1 = Application.new(status: "to-apply")
    application2 = Application.new(status: "mine_in_progress")

    assert_equal false, application1.valid?
    assert_equal false, application2.valid?
  end

  def test_it_returns_applications_with_different_statuses
    to_apply1 = create(:application, status: "to_apply")
    to_apply2 = create(:application, status: "to_apply", company: "Sendgrid")
    in_progress1 = create(:application, status: "in_progress")
    in_progress2 = create(:application, status: "in_progress", company: "Sendgrid")
    applied1 = create(:application, status: "applied")
    applied2 = create(:application, status: "applied", company: "Sendgrid")
    closed1 = create(:application, status: "closed")
    closed2 = create(:application, status: "closed", company: "Sendgrid")

    assert_equal to_apply1, Application.application_search("to_apply").first
    assert_equal to_apply2, Application.application_search("to_apply").last
    assert_equal in_progress1, Application.application_search("in_progress").first
    assert_equal in_progress2, Application.application_search("in_progress").last
    assert_equal applied1, Application.application_search("applied").first
    assert_equal applied2, Application.application_search("applied").last
    assert_equal closed1, Application.application_search("closed").first
    assert_equal closed2, Application.application_search("closed").last
  end
end
