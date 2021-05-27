require 'rails_helper'

RSpec.describe Author, type: :model do
  let(:author) { Author.new(first_name: 'Ayoub', last_name: 'Belemlih', email: 'test@testing_email.com')}

  describe '#full_name' do
    it 'returns the correct full name' do
      expect(author.full_name).to eq('Ayoub Belemlih')
    end
  end
end