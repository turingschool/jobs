require './test/test_helper'

class UserRecordsAnApplication < ActionDispatch::IntegrationTest

  def setup
    login_and_create_person!
  end

  def test_user_creates_an_application
    visit dashboard_path
    click_link_or_button 'new_application'
    fill_in 'application_company', :with => "Basecamp"
    fill_in 'application_location', :with => "Chicago, IL"
    fill_in 'application_url', :with => "http://basecamp.com/jobs"
    fill_in 'application_applied_on', :with => Date.today
    select 'open', :from => 'application_status'
    click_link_or_button 'Save'

    within('#applications') do
      assert page.has_content? "Basecamp"
    end
  end

  def test_an_application_with_no_company_is_rejected
    visit dashboard_path
    click_link_or_button 'new_application'
    fill_in 'application_company', :with => ""
    fill_in 'application_location', :with => "Chicago, IL"
    fill_in 'application_url', :with => "http://basecamp.com/jobs"
    fill_in 'application_applied_on', :with => Date.today
    click_link_or_button 'Save'

    assert page.has_field? 'application_company'
  end

  def test_viewing_the_details_of_an_application
    app = Application.create!(:company => "Basecamp",
                              :url => "http://basecamp.com",
                              :status => "open",
                              :person_id => current_person.id)

    visit dashboard_path
    within("#application_#{app.id}") do
      click_link_or_button app.company
    end

    assert page.has_content? app.url
  end

  def test_editing_the_details_of_an_application
    app = Application.create!(:company => "Basecamp",
                              :url => "http://basecamp.com",
                              :location => "Chicago, IL",
                              :status => "open",
                              :person_id => current_person.id)

    visit application_path(app)
    click_link_or_button("edit_application_#{app.id}")

    fill_in 'application_company', :with => "Trello"
    fill_in 'application_location', :with => "New York, NY"
    fill_in 'application_url', :with => "http://gettrello.com"
    select "dead", :from => 'application_status'
    click_link_or_button 'Save'

    refute page.has_content? "Basecamp"
    assert page.has_content? "Trello"

    refute page.has_content? "Chicago, IL"
    assert page.has_content? "New York, NY"

    refute page.has_content? "http://basecamp.com"
    assert page.has_content? "http://gettrello.com"

    refute page.has_content? "open"
    assert page.has_content? "dead"
  end
end
