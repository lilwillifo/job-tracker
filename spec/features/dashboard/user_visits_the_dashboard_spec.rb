require 'rails_helper'

describe 'user visits the dashboard' do
  it 'is totally possible' do
    visit dashboard_index_path

    expect(page).to have_content('Job Tracker')
    expect(page).to have_content('Jobs by Interest')
    expect(page).to have_content('Top Companies by Interest')
  end
  context 'and can link to things' do
    it 'like the location page' do
      company_1 = Company.create!(name: 'Google')
      company_2 = Company.create!(name: 'Amazon')
      company_3 = Company.create!(name: 'Yahoo')
      company_4 = Company.create!(name: 'Facebook')
      category = Category.create!(title: 'x')
      company_1.jobs.create!(title: 'x', level_of_interest: 9, description: 'x', city: 'Cimarron', category: category)
      company_2.jobs.create!(title: 'x', level_of_interest: 9, description: 'x', city: 'Albequerque', category: category)
      company_3.jobs.create!(title: 'x', level_of_interest: 2, description: 'x', city: 'DENVAAAAA', category: category)
      company_4.jobs.create!(title: 'x', level_of_interest: 8, description: 'x', city: 'Calgary', category: category)
      visit dashboard_index_path

      click_on 'Calgary'

      expect(current_path).to eq(jobs_path)
      expect(page).to have_content('All Jobs in Calgary')
    end
    it 'like the company page' do
      company_1 = Company.create!(name: 'Google')
      company_2 = Company.create!(name: 'Amazon')
      company_3 = Company.create!(name: 'Yahoo')
      company_4 = Company.create!(name: 'Facebook')
      category = Category.create!(title: 'x')
      company_1.jobs.create!(title: 'x', level_of_interest: 9, description: 'x', city: 'x', category: category)
      company_2.jobs.create!(title: 'x', level_of_interest: 9, description: 'x', city: 'x', category: category)
      company_3.jobs.create!(title: 'x', level_of_interest: 2, description: 'x', city: 'x', category: category)
      company_4.jobs.create!(title: 'x', level_of_interest: 8, description: 'x', city: 'x', category: category)
      visit dashboard_index_path

      click_on 'Google'

      expect(current_path).to eq(company_path(company_1))
    end
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
    context 'like the top 3 companies by level of interest' do
      it '.top_companies_by_interest' do
        company_1 = Company.create!(name: 'Google')
        company_2 = Company.create!(name: 'Amazon')
        company_3 = Company.create!(name: 'Yahoo')
        company_4 = Company.create!(name: 'Facebook')
        category = Category.create!(title: 'x')
        company_1.jobs.create!(title: 'x', level_of_interest: 9, description: 'x', city: 'x', category: category)
        company_2.jobs.create!(title: 'x', level_of_interest: 9, description: 'x', city: 'x', category: category)
        company_3.jobs.create!(title: 'x', level_of_interest: 2, description: 'x', city: 'x', category: category)
        company_4.jobs.create!(title: 'x', level_of_interest: 8, description: 'x', city: 'x', category: category)

        visit dashboard_index_path

        expect(page).to have_content("#{company_1.name} (9.0 avg)")
        expect(page).to have_content("#{company_2.name} (9.0 avg)")
        expect(page).to have_content("#{company_4.name} (8.0 avg)")
        expect(page).to_not have_content(company_3.name)
      end
    end

    context 'like the locations and their jobs' do
      it '.sort_by_location' do
        company_1 = Company.create!(name: 'Google')
        company_2 = Company.create!(name: 'Amazon')
        company_3 = Company.create!(name: 'Yahoo')
        company_4 = Company.create!(name: 'Facebook')
        category = Category.create!(title: 'x')
        job = company_1.jobs.create!(title: 'x', level_of_interest: 9, description: 'x', city: 'Denver', category: category)
        company_2.jobs.create!(title: 'x', level_of_interest: 9, description: 'x', city: 'Denver', category: category)
        company_3.jobs.create!(title: 'x', level_of_interest: 2, description: 'x', city: 'Denver', category: category)
        job_2 =company_4.jobs.create!(title: 'x', level_of_interest: 8, description: 'x', city: 'Seattle', category: category)

        visit dashboard_index_path

        expect(page).to have_content("#{job.city} (3 jobs)")
        expect(page).to have_content("#{job_2.city} (1 jobs)")
      end
    end
  end
end
