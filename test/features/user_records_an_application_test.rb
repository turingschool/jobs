require './test/test_helper'

class UserRecordsAnApplication < ActionDispatch::IntegrationTest
  def test_user_can_populate_new_application_form_from_query_param
    visit new_application_path(uri: "google.com/jobs/1")

    assert_equal "google.com/jobs/1", find_field("URL of the Job Posting").value
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

  def test_user_can_view_the_details_of_an_application
    user = create(:person)
    app = user.applications.create!(company: "Basecamp",
                                    url: "http://basecamp.com",
                                    location: "Chicago, IL",
                                    status: "applied")

    page.set_rack_session(user_id: user.id)
    visit dashboard_path
    within("#application_#{app.id}") do
      click_link_or_button app.company
    end

    assert page.has_content? app.url
  end

  def test_editing_the_details_of_an_application
    user = create(:person)
    app = user.applications.create!(company: "Basecamp",
                                    url: "http://basecamp.com",
                                    location: "Chicago, IL",
                                    status: "applied")

    page.set_rack_session(user_id: user.id)
    visit application_path(app)
    click_link_or_button("edit_application_#{app.id}")

    fill_in "application_company", with: "Trello"
    fill_in "application_location", with: "New York, NY"
    fill_in "application_url", with: "http://gettrello.com"
    select "closed", from: "application_status"
    save_application

    refute page.has_content? "Basecamp"
    assert page.has_content? "Trello"

    refute page.has_content? "Chicago, IL"
    assert page.has_content? "New York, NY"

    refute page.has_content? "http://basecamp.com"
    assert page.has_content? "http://gettrello.com"

    refute page.has_content? "open"
    assert page.has_content? "closed"
  end

  def navigate_to_application_form
    user = create(:person)
    page.set_rack_session(user_id: user.id)
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
