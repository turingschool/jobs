require './test/test_helper'

class UserRecordsAnApplication < ActionDispatch::IntegrationTest
  def test_user_creates_an_application
    visit dashboard_path
    click_link 'new_application'
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
    click_link 'new_application'
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
                              :status => "open")

    visit dashboard_path
    within("#application_#{app.id}") do
      click_link_or_button app.company
    end

    assert page.has_content? app.url
  end
end
