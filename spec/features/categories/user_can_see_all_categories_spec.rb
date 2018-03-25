require 'rails_helper'

describe "User sees all categories" do
  scenario "a user sees all the categories" do
    category = Category.create!(title: 'Finance')
    category_2 = Category.create!(title: 'Engineering')

    visit categories_path

    expect(page).to have_content('Finance')
    expect(page).to have_content('Engineering')
  end
end
