# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItem, type: :model do
  it { is_expected.to belong_to(:representative) }

  # Class method test
  describe '.find_for' do
    before do
      @representative = Representative.create(name: 'Sample Representative')
      @news_item1 = described_class.create(title: 'Title 1', link: 'http://example.com/1',
                                           representative: @representative, issue_id: 1)
      @news_item2 = described_class.create(title: 'Title 2', link: 'http://example.com/2',
                                           representative: @representative, issue_id: 1)
    end

    it 'returns the first news item for the given representative_id' do
      expect(described_class.find_for(@representative.id)).to eq(@news_item1)
    end

    it 'returns nil if no news item is found for the given representative_id' do
      expect(described_class.find_for(-1)).to be_nil
    end
  end
end
