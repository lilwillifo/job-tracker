require 'rails_helper'

describe 'User creates a new job' do
  scenario 'a user can create a new job' do
    company = Company.create!(name: 'ESPN')
    category = Category.create!(title: 'Finance')
    visit new_company_job_path(company)

    fill_in 'job[title]', with: 'Developer'
    fill_in 'job[description]', with: 'So fun!'
    fill_in 'job[level_of_interest]', with: '2'
    fill_in 'job[city]', with: 'Denver'
    select(category.title, from: 'Category')

    click_button 'Create'

    expect(current_path).to eq(jobs_path)
    expect(page).to have_content('ESPN')
    expect(page).to have_content('Developer')
    expect(page).to have_content('2')
    expect(page).to have_content('Denver')
  end
  scenario 'a user can link to create a new category' do
    company = Company.create!(name: 'ESPN')
    category = Category.create!(title: 'Finance')

    visit new_company_job_path(company)

    click_on 'Create a New Category'

    expect(current_path).to eq(new_category_path)
  end

  describe 'user can create a job without having made a company first' do
    scenario 'visits /jobs/new' do
      company = Company.create!(name: 'ESPN')
      category = Category.create!(title: 'Finance')

      visit new_job_path

      fill_in 'job[title]', with: 'Developer'
      fill_in 'job[description]', with: 'So fun!'
      fill_in 'job[level_of_interest]', with: '2'
      fill_in 'job[city]', with: 'Denver'
      select(category.title, from: 'Category')
      select(company.name, from: 'Company')


      click_button 'Create'

      expect(current_path).to eq(jobs_path)
      expect(page).to have_content('Developer')
      expect(page).to have_content('ESPN')
      expect(page).to have_content('Denver')
      expect(page).to have_content('2')
    end
  end
end
