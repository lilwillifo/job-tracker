require 'rails_helper'

describe 'user visits the dashboard' do
  it 'is totally possible' do
    visit dashboard_index_path

    expect(page).to have_content('Job Tracker')
    expect(page).to have_content('Jobs by Interest')
    expect(page).to have_content('Top Companies by Interest')
  end
  context 'which displays correct stats' do
    context 'like the count of jobs by level of interest' do
      it '.count_by_level_of_interest' do
        company = Company.create!(name: 'Google')
        category = Category.create!(title: 'x')
        company.jobs.create!(title: 'x', level_of_interest: 4, description: 'x', city: 'x', category: category)
        company.jobs.create!(title: 'x', level_of_interest: 4, description: 'x', city: 'x', category: category)
        company.jobs.create!(title: 'x', level_of_interest: 4, description: 'x', city: 'x', category: category)
        company.jobs.create!(title: 'x', level_of_interest: 5, description: 'x', city: 'x', category: category)
        company.jobs.create!(title: 'x', level_of_interest: 5, description: 'x', city: 'x', category: category)
        company.jobs.create!(title: 'x', level_of_interest: 5, description: 'x', city: 'x', category: category)
        company.jobs.create!(title: 'x', level_of_interest: 5, description: 'x', city: 'x', category: category)
        company.jobs.create!(title: 'x', level_of_interest: 5, description: 'x', city: 'x', category: category)
        company.jobs.create!(title: 'x', level_of_interest: 7, description: 'x', city: 'x', category: category)
        company.jobs.create!(title: 'x', level_of_interest: 8, description: 'x', city: 'x', category: category)
        company.jobs.create!(title: 'x', level_of_interest: 8, description: 'x', city: 'x', category: category)
        company.jobs.create!(title: 'x', level_of_interest: 9, description: 'x', city: 'x', category: category)

        visit dashboard_index_path
        
        expect(page).to have_content('* (0 jobs)')
        expect(page).to have_content('** (0 jobs)')
        expect(page).to have_content('*** (0 jobs)')
        expect(page).to have_content('**** (3 jobs)')
        expect(page).to have_content('***** (5 jobs)')
        expect(page).to have_content('****** (0 jobs)')
        expect(page).to have_content('******* (1 jobs)')
        expect(page).to have_content('******** (2 jobs)')
        expect(page).to have_content('********* (1 jobs)')
        expect(page).to have_content('********** (0 jobs)')
      end
    end
  end
end
