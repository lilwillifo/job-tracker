require 'rails_helper'

describe "User sees a specific job" do
  scenario "a user sees a job for a specific company" do
    company = Company.create!(name: "ESPN")
    job = company.jobs.create!(title: "Developer", level_of_interest: 70, city: "Denver")
    comment_1 = job.comments.create!(content: 'here is my comment')
    comment_2 = job.comments.create!(content: 'two commentz!')

    visit company_job_path(company, job)

    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("70")
    expect(page).to have_content(comment_1.content)
    expect(page).to have_content(comment_1.created_at)
    expect(page).to have_content(comment_2.content)
    expect(page).to have_content(comment_2.created_at)
  end
end
