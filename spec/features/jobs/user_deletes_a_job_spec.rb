require 'rails_helper'

describe "User deletes existing job" do
  scenario "a user can delete a job from its show page" do
    company = Company.create(name: "Turing")
    job = company.jobs.create!(title: "CoolJob", level_of_interest: 90, city: "Denver")

    visit company_job_path(company, job)

    click_link "Delete"

    expect(page).to have_content("CoolJob was successfully deleted!")
    expect(current_path).to eq(companies_path)
  end
  scenario 'a user can delete from jobs page' do
    company = Company.create!(name: "company")
    job = company.jobs.create!(title: "JobbyMcJoberson", level_of_interest: 40, city: 'New Orleans')

    visit company_jobs_path(company)

    within(".job_#{job.id}") do
      click_link 'Delete'
    end

    expect(page).to have_content("JobbyMcJoberson was successfully deleted!")
    expect(current_path).to eq(companies_path)
  end
  scenario 'a user can delete from job show page' do
    company = Company.create!(name: "company")
    job = company.jobs.create!(title: "JobbyMcJoberson", level_of_interest: 40, city: 'New Orleans')

    visit company_job_path(company, job)

    click_link 'Delete'

    expect(page).to have_content("JobbyMcJoberson was successfully deleted!")
    expect(current_path).to eq(companies_path)
  end
end
