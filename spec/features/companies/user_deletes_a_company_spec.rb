require 'rails_helper'

describe "User deletes existing company" do
  scenario "a user can delete a company" do
    company = Company.create(name: "ESPN")
    category = Category.create(title: 'wowowow')
    job_1 = company.jobs.create!(title: "Developer", level_of_interest: 4, city: "Denver", category_id: category.id)
    job_2 = company.jobs.create!(title: "super cool job", level_of_interest: 8, city: "Charlottesville", category_id: category.id)
    visit companies_path

    within(".company_#{company.id}") do
      find(:xpath, ".//a[i[contains(@class, 'fas fa-trash-alt')]]").click
    end

    expect(page).to have_content("ESPN was successfully deleted!")
    expect(Job.all.count).to eq(0)
  end
end
