require 'rails_helper'

describe 'User sees one category' do
  it 'sees a category and all its jobs' do
    category = Category.create!(title: 'stuff')
    company = Company.create(name: 'company')
    job_1 = company.jobs.create!(title: 'abc', description: '123', level_of_interest: 4, city: "Denver", category_id: category.id)
    job_2 = company.jobs.create!(title: 'def', description: '456', level_of_interest: 5, city: "Denver", category_id: category.id)

    visit category_path(category)

    expect(current_path).to eq("/categories/#{category.id}")
    expect(page).to have_content(category.title)
    expect(page).to have_content(job_1.title)
    expect(page).to have_content(job_1.company.name)
    expect(page).to have_content(job_1.level_of_interest)
    expect(page).to have_content(job_1.city)
    expect(page).to have_content(job_2.title)
    expect(page).to have_content(job_2.company.name)
    expect(page).to have_content(job_2.level_of_interest)
    expect(page).to have_content(job_2.city)
  end
  it 'can link to a job' do
    category = Category.create!(title: 'stuff')
    company = Company.create(name: 'company')
    job_1 = company.jobs.create!(title: 'abc', description: '123', level_of_interest: 4, city: "Denver", category_id: category.id)
    job_2 = company.jobs.create!(title: 'def', description: '456', level_of_interest: 5, city: "Denver", category_id: category.id)

    visit category_path(category)
    click_on 'abc'

    expect(current_path).to eq(company_job_path(company, job_1))
  end
end
