require 'rails_helper'

describe Job do
  describe 'validations' do
    context 'invalid attributes' do
      it 'is invalid without a title' do
        job = Job.new(level_of_interest: 80, description: 'Wahoo', city: 'Denver')
        expect(job).to be_invalid
      end

      it 'is invalid without a level of interest' do
        job = Job.new(title: 'Developer', description: 'Wahoo', city: 'Denver')
        expect(job).to be_invalid
      end

      it 'is invalid without a city' do
        job = Job.new(title: 'Developer', description: 'Wahoo', level_of_interest: 80)
        expect(job).to be_invalid
      end
    end

    context 'valid attributes' do
      it 'is valid with a title, level of interest, company, and category' do
        company = Company.new(name: 'Turing')
        category = Category.create!(title: 'category')
        job = Job.new(title: 'Developer', level_of_interest: 40, city: 'Denver', company: company, category_id: category.id)
        expect(job).to be_valid
      end
    end
  end

  describe 'relationships' do
    it 'belongs to a company' do
      job = Job.new(title: 'Software', level_of_interest: 70, description: 'Wahooo')
      expect(job).to respond_to(:company)
    end
    it 'has many comments' do
      job = Job.new(title: 'Software', level_of_interest: 30, description: 'alkjsdfh')
      expect(job).to respond_to(:comments)
    end
    it 'belongs to a category' do
      job = Job.new(title: 'jobbyjob', level_of_interest: 42, description: 'o wow a job')
      expect(job).to respond_to(:category)
    end
  end

  describe 'class methods' do
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

      expect(Job.count_by_level_of_interest(1)).to eq(0)
      expect(Job.count_by_level_of_interest(2)).to eq(0)
      expect(Job.count_by_level_of_interest(3)).to eq(0)
      expect(Job.count_by_level_of_interest(4)).to eq(3)
      expect(Job.count_by_level_of_interest(5)).to eq(5)
      expect(Job.count_by_level_of_interest(6)).to eq(0)
      expect(Job.count_by_level_of_interest(7)).to eq(1)
      expect(Job.count_by_level_of_interest(8)).to eq(2)
      expect(Job.count_by_level_of_interest(9)).to eq(1)
    end
    it '.group_by_location' do
      company = Company.create!(name: 'Google')
      category = Category.create!(title: 'x')
      company.jobs.create!(title: 'x', level_of_interest: 4, description: 'x', city: 'Denver', category: category)
      company.jobs.create!(title: 'x', level_of_interest: 4, description: 'x', city: 'Denver', category: category)
      company.jobs.create!(title: 'x', level_of_interest: 4, description: 'x', city: 'Seattle', category: category)


      expect(Job.group_by_location['Denver']).to eq(2)
      expect(Job.group_by_location['Seattle']).to eq(1)
      expect(Job.group_by_location['Portland']).to eq(nil)
    end
  end
end
