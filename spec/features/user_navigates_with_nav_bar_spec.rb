require 'rails_helper'

describe 'user naviagates the site with navbar' do
  scenario 'and can go to the jobs index' do
    company = Company.create!(name: "ESPN")
    category = Category.create!(title: 'Finance')
    job = company.jobs.create!(title: 'x', level_of_interest: 9, description: 'x', city: 'x', category: category)

    visit companies_path
    click_on 'Jobs'

    expect(current_path).to eq(jobs_path)
  end
end
