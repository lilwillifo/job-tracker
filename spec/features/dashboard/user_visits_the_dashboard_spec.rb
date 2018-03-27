require 'rails_helper'

describe 'user visits the dashboard' do
  it 'is totally possible' do
    visit dashboard_path

    expect(page).to have_content('Job Tracker')
    expect(page).to have_content('Jobs by Interest')
    expect(page).to have_content('Top Companies by Interest')
  end
end
