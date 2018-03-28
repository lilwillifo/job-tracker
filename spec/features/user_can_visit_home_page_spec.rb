require 'rails_helper'

describe 'A user visits the homepage ' do
  it 'and sees nav bar' do
    visit '/'

    expect(page).to have_content('Job Tracker')
    expect(page).to have_content('Companies')
    expect(page).to have_content('Categories')
  end
end
