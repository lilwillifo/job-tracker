require 'rails_helper'

describe "User edits an existing category" do
  scenario "a user can edit a category" do
    category = Category.create!(title: 'heres a category')
    visit edit_category_path(category)

    fill_in 'category[title]', with: "look i edited a category"
    click_button "Update"

    expect(current_path).to eq("/categories")
    expect(page).to have_content("look i edited a category")
    expect(page).to_not have_content("heres a category")
  end
end
