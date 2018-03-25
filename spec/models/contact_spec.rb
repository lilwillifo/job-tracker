require 'rails_helper'

describe Contact do
  describe 'validations' do
    describe 'relationships' do
      it { should belong_to(:company) }
    end
  end
end
