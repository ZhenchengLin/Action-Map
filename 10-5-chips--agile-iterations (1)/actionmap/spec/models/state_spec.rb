# frozen_string_literal: true

require 'rails_helper'

RSpec.describe State, type: :model do
  it { is_expected.to have_many(:counties).inverse_of(:state).dependent(:delete_all) }

  # Method test
  describe '#std_fips_code' do
    it 'returns a standardized FIPS code as a string with leading zeros' do
      state = described_class.new(fips_code: 6)
      expect(state.std_fips_code).to eq('06')

      state.fips_code = 16
      expect(state.std_fips_code).to eq('16')
    end
  end
end
