require 'rails_helper'

describe 'user naviagates the site with navbar' do
  scenario 'and can go to the jobs index' do
    company = Company.create!(name: "ESPN")
    category = Category.create!(title: 'Finance')
    job = company.jobs.create!(title: 'x', level_of_interest: 9, description: 'x', city: 'x', category: category)

    visit dashboard_index_path
    within 'div.links' do
      click_on 'Jobs'
    end

    expect(current_path).to eq(jobs_path)
  end
  scenario 'and can go to the companies index' do
    company = Company.create!(name: "ESPN")
    category = Category.create!(title: 'Finance')
    job = company.jobs.create!(title: 'x', level_of_interest: 9, description: 'x', city: 'x', category: category)

    visit companies_path
    click_on 'Companies'

    expect(current_path).to eq(companies_path)
  end
  scenario 'and can go to the new company page' do
    company = Company.create!(name: "ESPN")
    category = Category.create!(title: 'Finance')
    job = company.jobs.create!(title: 'x', level_of_interest: 9, description: 'x', city: 'x', category: category)

    visit companies_path
    click_on 'New Company'

    expect(current_path).to eq(new_company_path)
  end
  scenario 'and can go to the categories index' do
    company = Company.create!(name: "ESPN")
    category = Category.create!(title: 'Finance')
    job = company.jobs.create!(title: 'x', level_of_interest: 9, description: 'x', city: 'x', category: category)

    visit companies_path
    click_on 'Categories'

    expect(current_path).to eq(categories_path)
  end
  scenario 'and can go to the new category page' do
    company = Company.create!(name: "ESPN")
    category = Category.create!(title: 'Finance')
    job = company.jobs.create!(title: 'x', level_of_interest: 9, description: 'x', city: 'x', category: category)

    visit companies_path
    click_on 'New Category'

    expect(current_path).to eq(new_category_path)
  end
  scenario 'and can go to the new job page' do
    company = Company.create!(name: "ESPN")
    category = Category.create!(title: 'Finance')
    job = company.jobs.create!(title: 'x', level_of_interest: 9, description: 'x', city: 'x', category: category)

    visit companies_path
    click_on 'New Job'

    expect(current_path).to eq(new_job_path)
  end
  scenario 'and can go to the dashboard' do
    company = Company.create!(name: "ESPN")
    category = Category.create!(title: 'Finance')
    job = company.jobs.create!(title: 'x', level_of_interest: 9, description: 'x', city: 'x', category: category)

    visit companies_path
    click_on 'Dashboard'

    expect(current_path).to eq(dashboard_index_path)
  end
end
