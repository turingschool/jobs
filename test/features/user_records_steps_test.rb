require './test/test_helper'

class UserRecordsSteps < ActionDispatch::IntegrationTest
  def test_user_adds_a_step
    app = Application.create(:company => "Basecamp")

    visit dashboard_path
    within("#application_#{app.id}") do
      click_link_or_button 'add_step'
    end

    select('feedback', :from => 'step_kind')
    fill_in 'step_note', :with => "They're not hiring. Bummer!"
    click_link_or_button 'Save'

    within("#application_#{app.id}") do
      assert page.has_content? "Basecamp"
      assert page.has_content? "Bummer!"
    end
  end

end
