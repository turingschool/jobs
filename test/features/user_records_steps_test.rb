require './test/test_helper'

class UserRecordsSteps < ActionDispatch::IntegrationTest
  def test_user_adds_a_step
    app = Application.create(company: "Basecamp",
    status: "open", url: "Basecamp.com")
    visit application_path(app)

    within(".application") do
      click_link_or_button 'add_step'
    end

    select('feedback', :from => 'step_kind')
    fill_in 'step_note', :with => "They're not hiring. Bummer!"
    click_link_or_button 'Save'

    within(".application") do
      assert page.has_content? "Basecamp"
      assert page.has_content? "Bummer!"
    end
  end

  def test_user_edits_a_step
    app = Application.create(company: "Basecamp", status: "open",
    url: "Basecamp.com")
    step = app.steps.create(kind: "feedback", note: "They're hiring!")

    visit application_path(app)
    assert page.has_content? "They're hiring!"
    assert page.has_content? "Feedback"

    click_link_or_button "edit_step_#{step.id}"
    select('code_challenge', :from => 'step_kind')
    fill_in 'step_note', :with => "They're NOT hiring!"
    click_link_or_button "Save"

    refute page.has_content? "They're hiring!"
    assert page.has_content? "They're NOT hiring!"

    refute page.has_content? "Feedback"
    assert page.has_content? "Code challenge"
  end

  def test_user_deletes_a_step
    app = Application.create(company: "Basecamp", status: "open",
      url: "Basecamp.com")
    step = app.steps.create(kind: "feedback", note: "They're hiring!")

    visit application_path(app)

    click_link_or_button "delete_step_#{step.id}"

    assert page.has_content? 'Basecamp'
    refute page.has_content? "They're hiring!"
  end
end
