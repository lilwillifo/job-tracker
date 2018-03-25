require 'rails_helper'

describe 'user deletes a contact' do
  describe 'they visit a company show page' do
    it 'displays all contacts without the deleted entry' do
      company = Company.create!(name: 'Dropbox')
      contact_1 = company.contacts.create!(name: 'Jan', role: 'Boss', email: 'Jan@boss.com')
      contact_2 = company.contacts.create!(name: 'Jim', role: 'CFO', email: 'Jim@boss.com')

      visit company_path(company)
      
      within(".contact_#{contact_1.id}") do
        click_link 'Delete'
      end

      expect(current_path).to eq(company_path(company))
      expect(page).to have_content(contact_2.name)
      expect(page).to_not have_content(contact_1.name)
    end
  end
end
