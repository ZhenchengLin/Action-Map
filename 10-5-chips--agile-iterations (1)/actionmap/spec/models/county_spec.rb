# frozen_string_literal: true

require 'rails_helper'

RSpec.describe County, type: :model do
  it { is_expected.to belong_to(:state) }

  # Shared examples for #std_fips_code
  shared_examples 'a standardized FIPS code' do |fips_code, expected_code|
    it "returns #{expected_code} when fips_code is #{fips_code}" do
      county = described_class.new(fips_code: fips_code)
      expect(county.std_fips_code).to eq(expected_code)
    end
  end

  # Method test
  describe '#std_fips_code' do
    it_behaves_like 'a standardized FIPS code', 1, '001'
    it_behaves_like 'a standardized FIPS code', 10, '010'
    it_behaves_like 'a standardized FIPS code', 100, '100'
  end
end
