require './test/test_helper'

class UserRecordsAnApplication < ActionDispatch::IntegrationTest
  def test_user_creates_an_application
    visit dashboard_path
    click_link 'new_application'
    fill_in 'application_company', :with => "Basecamp"
    fill_in 'application_location', :with => "Chicago, IL"
    fill_in 'application_url', :with => "http://basecamp.com/jobs"
    fill_in 'application_applied_on', :with => Date.today
    click_link_or_button 'Save'

    within('#applications') do
      assert page.has_content? "Basecamp"
    end
  end
end
