require 'rails_helper'

describe "User edits an existing category" do
  scenario "a user can edit a category" do
    category = Category.create!(title: 'first')
    visit edit_category_path(category)

    fill_in 'category[title]', with: "second"
    click_button "Update"

    expect(current_path).to eq("/categories")
    expect(page).to have_content("second updated!")
    expect(page).to have_content("second")
    expect(page).to_not have_content("first")
  end
end
