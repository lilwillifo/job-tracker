require 'rails_helper'

describe Contact do
  describe 'validations' do
    describe 'relationships' do
      it 'belongs to a company' do
        company = Company.new(name: 'Dropbox')

        expect(company).to respond_to(:contacts)
      end
    end
    context "invalid attributes" do
      it "is invalid without a name" do
        contact = Contact.new(role: 'Chief', email: 'chief@aol.com')

        expect(contact).to be_invalid
      end

      it "is invalid without a role" do
        contact = Contact.new(name: 'Bob', email: 'chief@aol.com')

        expect(contact).to be_invalid
      end

      it "is invalid without an email" do
        contact = Contact.new(name: 'Bob', role: 'Chief')

        expect(contact).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with content" do
        company = Company.new(name: 'Dropbox')
        contact = company.contacts.new(name: 'Bob', role: 'Chief', email: 'chief@aol.com')

        expect(contact).to be_valid
      end
    end

  end
end
