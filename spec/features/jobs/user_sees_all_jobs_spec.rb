require 'rails_helper'

describe 'User sees all jobs' do
  it 'for a specific company' do
    company = Company.create!(name: 'ESPN')
    category = Category.create!(title: 'Dev')
    company.jobs.create!(title: 'Developer', level_of_interest: 7, city: 'Denver', category_id: category.id)
    company.jobs.create!(title: 'QA Analyst', level_of_interest: 7, city: 'New York City', category_id: category.id)

    visit company_jobs_path(company)

    expect(page).to have_content('ESPN')
    expect(page).to have_content('Developer')
    expect(page).to have_content('QA Analyst')
    expect(page).to have_content('add a new job')

  end
  it 'for all the companies' do
    company_one = Company.create!(name: "ESPN")
    category = Category.create!(title: 'Dev')
    company_one.jobs.create!(title: "Developer", level_of_interest: 7, city: "Denver", category_id: category.id)
    company_one.jobs.create!(title: "QA Analyst", level_of_interest: 7, city: "New York City", category_id: category.id)
    company_two = Company.create!(name: "ESPN2")
    company_two.jobs.create!(title: "Dev", level_of_interest: 7, city: "Philly", category_id: category.id)
    company_two.jobs.create!(title: "Dentist", level_of_interest: 7, city: "Chesapeake", category_id: category.id)
    company_three = Company.create!(name: "ESPNquattro")
    company_three.jobs.create!(title: "Judge", level_of_interest: 7, city: "Philly", category_id: category.id)
    company_three.jobs.create!(title: "Zoo Keeper", level_of_interest: 7, city: "Chesapeake", category_id: category.id)

    visit jobs_path

    within "nav" do
      expect(page).to have_content('Categories')
    end
    expect(page).to have_content('Developer')
    expect(page).to have_content('QA Analyst')
    expect(page).to have_content('Dev')
    expect(page).to have_content('Dentist')
    expect(page).to have_content('Judge')
    expect(page).to have_content('Zoo Keeper')
    expect(page).to_not have_content('add a new job')
  end
  it 'can seach for jobs by location' do
    company_one = Company.create!(name: "ESPN")
    category = Category.create!(title: 'Dev')
    company_one.jobs.create!(title: "Developer", level_of_interest: 7, city: "Denver", category_id: category.id)
    company_one.jobs.create!(title: "QA Analyst", level_of_interest: 7, city: "New York City", category_id: category.id)
    company_two = Company.create!(name: "ESPN2")
    company_two.jobs.create!(title: "Dev", level_of_interest: 7, city: "Denver", category_id: category.id)
    company_two.jobs.create!(title: "Dentist", level_of_interest: 7, city: "Denver", category_id: category.id)

    visit "/jobs?location=Denver"

    expect(page).to have_content('All Jobs in Denver')
    expect(page).to have_content('Developer')
    expect(page).to_not have_content('QA Analyst')
    expect(page).to have_content('Dev')
    expect(page).to have_content('Dentist')
    expect(page).to_not have_content('add a new job')
  end

  it 'can sort the jobs page by location alphabetically' do
    company_one = Company.create!(name: "ESPN")
    category = Category.create!(title: 'Dev')
    company_one.jobs.create!(title: "Developer", level_of_interest: 7, city: "Denver", category_id: category.id)
    company_one.jobs.create!(title: "QA Analyst", level_of_interest: 9, city: "New York City", category_id: category.id)
    company_two = Company.create!(name: "ESPN2")
    company_two.jobs.create!(title: "Dev", level_of_interest: 2, city: "Denver", category_id: category.id)
    company_two.jobs.create!(title: "Dentist", level_of_interest: 1, city: "Denver", category_id: category.id)

    visit '/jobs'
    click_on 'City'

    within 'tr:nth(2)' do
      expect(page).to have_content('Dev')
    end
  end

  it 'can sort the jobs page by level of interest' do
    company_one = Company.create!(name: "ESPN")
    category = Category.create!(title: 'Dev')
    company_one.jobs.create!(title: "Developer", level_of_interest: 7, city: "Denver", category_id: category.id)
    company_one.jobs.create!(title: "QA Analyst", level_of_interest: 9, city: "New York City", category_id: category.id)
    company_two = Company.create!(name: "ESPN2")
    company_two.jobs.create!(title: "Dev", level_of_interest: 2, city: "Denver", category_id: category.id)
    company_two.jobs.create!(title: "Dentist", level_of_interest: 1, city: "Denver", category_id: category.id)

    visit '/jobs'
    click_on 'Interest'

    within 'tr:nth(2)' do
      expect(page).to have_content('QA Analyst')
    end
  end
end
