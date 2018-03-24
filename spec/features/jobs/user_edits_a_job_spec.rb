require 'rails_helper'

describe "User edits an existing job" do
  scenario "a user can edit a job" do
    company = Company.create!(name: "ESPN")
    job = company.jobs.create!(title: "CoolJob", level_of_interest: 90, city: "Denver")
    visit edit_company_job_path(company, job)

    fill_in "job[title]", with: "v cool job"
    fill_in 'job[city]', with: 'seattle'
    click_button "Update"

    expect(current_path).to eq("/companies/#{Company.last.id}/jobs/#{job.id}")
    expect(page).to have_content("v cool job")
    expect(page).to_not have_content('seattle')
  end
end
