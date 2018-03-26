require 'rails_helper'

describe "User edits an existing contact" do
  scenario "a user can edit a contact" do
    company = Company.create!(name: 'Popeye\'s')
    contact = company.contacts.create!(name: 'Mork', role: 'Nanu Nanu', email: 'rw@mork.com')

    visit company_path(company)

    within(".contact_#{contact.id}") do
      click_link 'Edit'
    end

    fill_in 'contact[name]', with: 'ME!'
    fill_in 'contact[role]', with: 'Boss'
    fill_in 'contact[email]', with: 'boss@me.com'
    click_on 'Update'

    expect(current_path).to eq(company_path(company))
    expect(page).to have_content("ME!")
    expect(page).to_not have_content("Mork")
    expect(page).to have_content("Boss")
    expect(page).to_not have_content("Nanu Nanu")
    expect(page).to have_content("boss@me.com")
    expect(page).to_not have_content("rw@mork.com")
  end
end
