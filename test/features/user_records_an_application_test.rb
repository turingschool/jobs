require './test/test_helper'

class UserRecordsAnApplication < ActionDispatch::IntegrationTest
  def test_user_can_populate_new_application_form_from_query_param
    query_parameter = "google.com/jobs/1"

    navigate_to_application_form
    visit new_application_path(uri: query_parameter)

    assert_equal query_parameter, find_field("URL of the Job Posting").value
  end

  def test_user_can_create_a_complete_application
    navigate_to_application_form

    fill_in_all_application_form_fields
    select_a_status
    save_application

    assert page.has_content? "Test Company: all fields"
    assert current_path, dashboard_path
  end

  def test_user_cannot_create_an_application_with_no_company
    navigate_to_application_form

    fill_in_all_but_company_name
    select_a_status
    save_application

    assert page.has_content? "can't be blank"
    assert current_path, new_application_path
  end

  def test_user_can_create_an_application_with_no_url
    navigate_to_application_form

    fill_in_all_but_url
    select_a_status
    save_application

    assert page.has_content? "Test Company: no URL"
    assert current_path, dashboard_path
  end

  def test_user_can_add_contact_info_to_an_application
    person = create(:person)
    page.set_rack_session(user_id: person.id)

    visit dashboard_path
    click_link_or_button "new_application"
    fill_in_all_but_url
    fill_in "Contact Information", with: "DHH - DHH@basecamp.com"
    select_a_status
    save_application
    click_link_or_button "Test Company: no URL"

    assert page.has_content? "DHH - DHH@basecamp.com"
  end

  def test_user_can_add_a_tier_to_an_application
    navigate_to_application_form
    fill_in_all_but_url
    select_a_status
    select "reach", from: "application_tier"
    save_application
    click_link_or_button "Test Company: no URL"

    assert page.has_content? "reach"
  end

  def test_user_can_add_a_priority_level_to_an_application
    navigate_to_application_form
    fill_in_all_but_url
    select_a_status
    select "high", from: "Priority"
    save_application
    click_link_or_button "Test Company: no URL"

    assert page.has_content? "high"
  end

  private

  def navigate_to_application_form
    person = create(:person)
    page.set_rack_session(user_id: person.id)
    visit dashboard_path
    click_link_or_button "new_application"
  end

  def fill_in_all_application_form_fields
    fill_in "application_company", with: "Test Company: all fields"
    fill_in "application_location", with: "Chicago, IL"
    fill_in "application_url", with: "http://basecamp.com/jobs"
    fill_in "application_applied_on", with: Date.today
  end

  def fill_in_all_but_company_name
    fill_in "application_location", with: "Chicago, IL"
    fill_in "application_url", with: "http://basecamp.com/jobs"
    fill_in "application_applied_on", with: Date.today
  end

  def fill_in_all_but_url
    fill_in "application_company", with: "Test Company: no URL"
    fill_in "application_location", with: "Chicago, IL"
    fill_in "application_applied_on", with: Date.today
  end

  def select_a_status
    select "applied", from: "application_status"
  end

  def save_application
    click_link_or_button "Save"
  end
end
