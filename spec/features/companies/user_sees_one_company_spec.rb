require 'rails_helper'

describe "User sees one company" do
  scenario "a user sees a company" do
    company = Company.create!(name: "ESPN")
    contact_1 = company.contacts.create!(name: 'Bob', role: 'Manager', email: 'Bob@espn.com')
    contact_2 = company.contacts.create!(name: 'Jan', role: 'CFO', email: 'Jan@espn.com')

    visit company_path(company)

    expect(current_path).to eq("/companies/#{company.id}")
    expect(page).to have_content(company.name)
    expect(page).to have_content(contact_1.name)
    expect(page).to have_content(contact_1.role)
    expect(page).to have_content(contact_1.email)
    expect(page).to have_content(contact_2.name)
    expect(page).to have_content(contact_2.role)
    expect(page).to have_content(contact_2.email)
  end
end
