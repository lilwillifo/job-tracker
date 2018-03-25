require 'rails_helper'

describe Category do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without title" do
        category = Category.new
        expect(category).to be_invalid
      end
      it 'is invalid with duplicate title' do
        category_1 = Category.create!(title: 'abc')
        category_2 = Category.new(title: 'abc')

        expect(category_2).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with title" do
        category = Category.new(title: 'development')
        expect(category).to be_valid
      end
    end
  end

  describe "relationships" do
    it "has many jobs" do
      category = Category.new(title: 'IT')
      expect(category).to respond_to(:jobs)
    end
  end
end
