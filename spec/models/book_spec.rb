require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:author) { Author.new(first_name: 'Ayoub', last_name: 'Belemlih', email: 'test@testing_email.com')}
  let(:book) { Book.new(title: 'Summer in Atlanta', author: author, publisher: 'Bel Publishing')}

  describe '#mla_author_name' do
    it 'returns the correct author name' do
      expect(book.mla_author_name).to eq('Belemlih, Ayoub')
    end
  end
end