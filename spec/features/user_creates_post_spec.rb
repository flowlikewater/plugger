require 'rails_helper'

RSpec.feature "Creating post" do
  scenario "succesfully" do
    visit root_path
    click_on "Write a story"
    fill_in "Title", with: "My first post"
    fill_in "Body", with: "Some awesome content"
    click_on "Publish"
    expect(page).to have_content "My first post"
  end
  scenario "unsuccessfully" do
    visit root_path
    click_on "Write a story"
    fill_in "Title", with: "My second post"
    fill_in "Body", with: ""
    click_on "Publish"
    expect(page).to have_css ".error"
  end
end
