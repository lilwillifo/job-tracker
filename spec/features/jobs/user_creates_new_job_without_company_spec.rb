require 'rails_helper'

describe 'user can create a job without having made a company first' do
  scenario 'visits /jobs/new' do
    company = Company.create!(name: 'ESPN')
    category = Category.create!(title: 'Finance')

    visit new_job_path

    select(company.name, from: 'Company')
    fill_in 'job[title]', with: 'Developer'
    fill_in 'job[description]', with: 'So fun!'
    fill_in 'job[level_of_interest]', with: '2'
    fill_in 'job[city]', with: 'Denver'
    select(category.title, from: 'Category')

    expect(current_path).to eq(jobs_path)
    expect(page).to have_content('Developer')
    expect(page).to have_content('ESPN')
    expect(page).to have_content('Denver')
    expect(page).to have_content('2')
  end
end
