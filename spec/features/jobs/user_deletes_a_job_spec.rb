# require 'rails_helper'
#
# describe "User deletes existing job" do
#   scenario "a user can delete a job" do
#     company = Company.create(name: "Turing")
#     job = company.jobs.create!(title: "CoolJob", level_of_interest: 90, city: "Denver")
#
#     visit company_job_path(company, job)
#
#     # within(".company_#{company.id}") do
#       click_link "Delete"
#     # end
#
#     expect(page).to have_content("CoolJob was successfully deleted!")
#     expect(current_path).to eq('/dashboard')
#   end
# end
