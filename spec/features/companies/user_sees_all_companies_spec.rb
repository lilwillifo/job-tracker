require 'rails_helper'

describe "User sees all companies" do
  scenario "a user sees all the companies" do
    company = Company.create!(name: "ESPN")
    company_two = Company.create!(name: "Disney")

    visit companies_path

    expect(page).to have_content("ESPN")
  end
  it 'takes user from index to new' do
    company = Company.create!(name: "ESPN")

    visit companies_path
    click_on 'add a new company'

    expect(current_path).to eq(new_company_path)
  end
end
