require 'rails_helper'

describe 'User sees one category' do
  scenario 'a user sees a category and contacts' do
    category = Category.create!(title: 'stuff')
    company = Company.create(name: 'company')
    job_1 = company.jobs.create!(title: 'abc', description: '123', level_of_interest: 70, city: "Denver", category_id: category.id)
    job_2 = company.jobs.create!(title: 'def', description: '456', level_of_interest: 5, city: "Denver", category_id: category.id)

    visit category_path(category)

    expect(current_path).to eq("/categories/#{category.id}")
    expect(page).to have_content(category.title)
    expect(page).to have_content('abc')
    expect(page).to have_content('def')
  end
end
