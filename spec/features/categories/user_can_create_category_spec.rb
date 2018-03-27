require 'rails_helper'

describe 'User creates a new category' do
  scenario 'a user can create a new category' do
    visit new_category_path

    fill_in 'category[title]', with: 'Dev'
    click_button 'Create'

    expect(current_path).to eq(categories_path)
    expect(page).to have_content('Dev')
    expect(page).to have_content('Dev added!')
    expect(Category.count).to eq(1)
  end
  scenario 'a user receives an error if the category already exists' do
    Category.create!(title: 'Finance')
    visit new_category_path

    fill_in 'category[title]', with: 'Finance'
    click_button 'Create'

    expect(current_path).to eq('/categories')
    expect(page).to have_content('Sorry, that category name already exists!')
    expect(Category.count).to eq(1)
  end
end
