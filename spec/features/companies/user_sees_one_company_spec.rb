require 'rails_helper'

describe 'User sees one company' do
  scenario 'a user sees a company and contacts' do
    company = Company.create!(name: 'ESPN')
    contact_1 = company.contacts.create!(name: 'Bob', role: 'Manager', email: 'Bob@espn.com')
    contact_2 = company.contacts.create!(name: 'Jan', role: 'CFO', email: 'Jan@espn.com')
    category = Category.create!(title: 'stuff')
    company.jobs.create!(title: "Developer", level_of_interest: 9, city: "Denver", category_id: category.id)

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
  describe 'they fill in a contact form' do
    it 'displays the contact on the company show' do
      company = Company.create!(name: 'Dropbox')

      visit company_path(company)

      fill_in 'contact[name]', with: 'ME!'
      fill_in 'contact[role]', with: 'Boss'
      fill_in 'contact[email]', with: 'boss@me.com'
      click_on 'Submit'

      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('Create a Contact')
      expect(page).to have_content('ME!')
      expect(page).to have_content('Boss')
      expect(page).to have_content('boss@me.com')
    end
  end
end
