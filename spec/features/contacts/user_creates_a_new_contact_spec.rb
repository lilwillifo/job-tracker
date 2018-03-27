require 'rails_helper'

describe 'user creates a new contact from a form' do
  it 'works' do
    company = Company.create!(name: 'Dropbox')

    visit company_path(company)

    fill_in 'contact[name]', with: 'ME!'
    fill_in 'contact[role]', with: 'Boss'
    fill_in 'contact[email]', with: 'boss@me.com'
    click_on 'Create'

    expect(current_path).to eq(company_path(company))
    expect(page).to have_content('ME! added!')
    expect(page).to have_content('Existing contacts')
    expect(page).to have_content('ME!')
    expect(page).to have_content('Boss')
    expect(page).to have_content('boss@me.com')
  end
  it 'only accepts a valid email address' do
    company = Company.create!(name: 'Dropbox')

    visit company_path(company)

    fill_in 'contact[name]', with: 'ME!'
    fill_in 'contact[role]', with: 'Boss'
    fill_in 'contact[email]', with: 'not real'
    click_on 'Create'


    expect(page).to have_content('boss@me.com')
  end
end
