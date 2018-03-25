require 'rails_helper'

describe 'User sees one category' do
  scenario 'a user sees a category and contacts' do
    category = Category.create!(title: 'stuff')

    visit category_path(category)

    expect(current_path).to eq("/categories/#{category.id}")
    expect(page).to have_content(category.title)
  end
end
