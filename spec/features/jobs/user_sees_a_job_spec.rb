require 'rails_helper'

describe "User sees a specific job" do
  scenario "a user sees a job for a specific company" do
    company = Company.create!(name: "ESPN")
    category = Category.create!(title: 'Dev')
    job = company.jobs.create!(title: "Developer", level_of_interest: 70, city: "Denver", category_id: category.id)
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
  describe "they fill in a comment form" do
    it "displays the comment on the article show" do
      company = Company.create!(name:'my kewl company')
      category = Category.create!(title: 'Dev')
      job = company.jobs.create!(title: 'Title', level_of_interest: 50, city: 'Canada', category_id: category.id)

      visit company_job_path(company, job)

      fill_in 'comment[content]', with: 'I applied to zee job!'
      click_on 'Submit'

      expect(current_path).to eq(company_job_path(company, job))
      expect(page).to have_content('I applied to zee job!')
    end
  end
end
