require 'rails_helper'

describe Company do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a name" do
        company = Company.new()
        expect(company).to be_invalid
      end

      it "has a unique name" do
        Company.create(name: "Dropbox")
        company = Company.new(name: "Dropbox")
        expect(company).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a name" do
        company = Company.new(name: "Dropbox")
        expect(company).to be_valid
      end
    end
  end

  describe "relationships" do
    it "has many jobs" do
      company = Company.new(name: "Dropbox")
      expect(company).to respond_to(:jobs)
    end
    it "has many contacts" do
      company = Company.new(name: "Dropbox")
      expect(company).to respond_to(:contacts)
    end
  end

  describe 'class methods' do
    it '.top_companies_by_interest' do
      company_1 = Company.create!(name: 'Amazon')
      company_2 = Company.create!(name: 'Google')
      company_3 = Company.create!(name: 'Yahoo')
      company_4 = Company.create!(name: 'Facebook')
      category = Category.create!(title: 'x')
      company_1.jobs.create!(title: 'x', level_of_interest: 9, description: 'x', city: 'x', category: category)
      company_2.jobs.create!(title: 'x', level_of_interest: 9, description: 'x', city: 'x', category: category)
      company_3.jobs.create!(title: 'x', level_of_interest: 2, description: 'x', city: 'x', category: category)
      company_4.jobs.create!(title: 'x', level_of_interest: 8, description: 'x', city: 'x', category: category)

      expect(Company.top_companies_by_interest.first.name).to eq(company_1.name)
      expect(Company.top_companies_by_interest[1].name).to eq(company_2.name)
      expect(Company.top_companies_by_interest.last.name).to eq(company_4.name)
    end
  end

  describe 'instance methods' do
    it '.average_interest_level' do
      company = Company.create!(name: 'Amazon')
      category = Category.create!(title: 'categoryyy')

      company.jobs.create!(title: 'x', level_of_interest: 9, description: 'x', city: 'x', category: category)
      company.jobs.create!(title: 'x', level_of_interest: 8, description: 'x', city: 'x', category: category)
      company.jobs.create!(title: 'x', level_of_interest: 2, description: 'x', city: 'x', category: category)

      expect(company.average_interest_level).to eq(6.3)
    end
  end
end
