require 'rails_helper'

describe Contact do
  describe 'validations' do
    describe 'relationships' do
      it 'belongs to a company' do
        company = Company.new(name: 'Dropbox')
        expect(company).to respond_to(:contacts)
      end
    end
  end
end
