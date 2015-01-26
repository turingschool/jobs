require './test/test_helper'

class UserRecordsAnApplication < ActionDispatch::IntegrationTest
  def test_user_can_populate_new_application_form_from_query_param
    query_parameter = "google.com/jobs/1"

    navigate_to_application_form
    visit new_application_path(url: query_parameter)

    assert_equal query_parameter, find_field("URL of the Job Posting").value
  end

  def test_user_redirects_to_confirm_msg_from_bookmarklet_application_form
    query_parameter = "true"
    sign_in_to_site

    visit new_application_path(bookmarklet: query_parameter)
    fill_in_all_application_form_fields
    select_a_status
    save_application

    assert page.has_content? "Your application has been submitted!"
  end

  def test_user_redirects_to_dashboard_from_site_application_form
    navigate_to_application_form

    fill_in_all_application_form_fields
    select_a_status
    save_application

    assert current_path, dashboard_path
  end

  def test_user_can_create_an_application
    navigate_to_application_form

    fill_in_all_application_form_fields
    select_a_status
    save_application

    assert page.has_content? "Test Company"
    assert current_path, dashboard_path
  end

  def test_user_can_add_contact_info_to_an_application
    person = create(:person)
    page.set_rack_session(user_id: person.id)

    visit dashboard_path
    click_link_or_button "new_application"
    fill_in_all_application_form_fields
    fill_in "Contact Information", with: "DHH - DHH@basecamp.com"
    select_a_status
    save_application
    click_link_or_button "Test Company"

    assert page.has_content? "DHH - DHH@basecamp.com"
  end

  def test_user_can_add_a_tier_to_an_application
    navigate_to_application_form
    fill_in_all_application_form_fields
    select_a_status
    select "reach", from: "application_tier"
    save_application
    click_link_or_button "Test Company"

    assert page.has_content? "reach"
  end

  def test_user_can_add_a_priority_level_to_an_application
    navigate_to_application_form
    fill_in_all_application_form_fields
    select_a_status
    select "high", from: "Priority"
    save_application
    click_link_or_button "Test Company"

    assert page.has_content? "high"
  end

  private

  def sign_in_to_site
    person = create(:person)
    page.set_rack_session(user_id: person.id)
  end

  def navigate_to_application_form
    person = create(:person)
    page.set_rack_session(user_id: person.id)
    visit dashboard_path
    click_link_or_button "new_application"
  end

  def fill_in_all_application_form_fields
    fill_in "application_company", with: "Test Company"
    fill_in "application_location", with: "Chicago, IL"
    fill_in "application_url", with: "http://basecamp.com/jobs"
    fill_in "application_applied_on", with: Date.today
  end

  def select_a_status
    select "applied", from: "application_status"
  end

  def save_application
    click_link_or_button "Save"
  end
end
