require 'rails_helper'

describe "User edits an existing job" do
  scenario "a user can edit a job" do
    company = Company.create!(name: "ESPN")
    category = Category.create!(title: 'Dev')
    job = company.jobs.create!(title: "CoolJob", level_of_interest: 9, city: "Denver", category_id: category.id)

    visit edit_company_job_path(company, job)

    fill_in "job[title]", with: "v cool job"
    fill_in 'job[city]', with: 'seattle'
    click_button "Update Job"

    expect(current_path).to eq("/companies/#{Company.last.id}/jobs/#{job.id}")
    expect(page).to have_content("v cool job")
    expect(page).to have_content('seattle')
    expect(page).to_not have_content('CoolJob')
    expect(page).to_not have_content('Denver')
  end
  scenario 'a user can get to edit page from jobs page' do
    company = Company.create!(name: "company")
    category = Category.create!(title: 'Dev')
    job = company.jobs.create!(title: "JobbyMcJoberson", level_of_interest: 4, city: 'New Orleans', category_id: category.id)

    visit company_jobs_path(company)

    within(".job_#{job.id}") do
      click_link 'Edit'
    end

    expect(current_path).to eq(edit_company_job_path(company, job))
  end
  scenario 'a user can get to edit page from job show page' do
    company = Company.create!(name: "company")
    category = Category.create!(title: 'Dev')
    job = company.jobs.create!(title: "JobbyMcJoberson", level_of_interest: 4, city: 'New Orleans', category_id: category.id)

    visit company_job_path(company, job)

      click_link 'Edit'

    expect(current_path).to eq(edit_company_job_path(company, job))
  end
end
