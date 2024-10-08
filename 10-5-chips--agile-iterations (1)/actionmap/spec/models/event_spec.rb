# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  it { is_expected.to belong_to(:county) }

  # Validation tests
  it { is_expected.to validate_presence_of(:start_time) }
  it { is_expected.to validate_presence_of(:end_time) }

  shared_context 'with sample state and county' do
    let(:state) do
      State.create(name: 'Sample State', symbol: 'SS', fips_code: 1, is_territory: 0, lat_min: 0.0, lat_max: 0.0,
                   long_min: 0.0, long_max: 0.0)
    end
    let(:county) { County.create(name: 'Sample County', state: state, fips_code: 1, fips_class: 'H1') }
  end

  shared_examples 'an invalid event' do |start_time, end_time, error_key, error_message|
    let(:event) do
      described_class.new(name: 'Sample Event', county: county, start_time: start_time, end_time: end_time)
    end

    it "is invalid with #{error_key} error" do
      expect(event).not_to be_valid
      expect(event.errors[error_key]).to include(error_message)
    end
  end

  describe 'custom date validations' do
    include_context 'with sample state and county'

    it_behaves_like 'an invalid event', 1.day.ago, 1.day.from_now, :start_time, 'must be after today'
    it_behaves_like 'an invalid event', 1.day.from_now, 1.day.ago, :end_time, 'must be after start time'

    it 'is valid with proper start_time and end_time' do
      event = described_class.new(name: 'Sample Event', county: county, start_time: 1.day.from_now,
                                  end_time: 2.days.from_now)
      expect(event).to be_valid
    end
  end

  describe '#county_names_by_id' do
    include_context 'with sample state and county'

    let!(:county1) { County.create(name: 'County 1', state: state, fips_code: 1, fips_class: 'H1') }
    let!(:county2) { County.create(name: 'County 2', state: state, fips_code: 2, fips_class: 'H1') }
    let!(:event) do
      described_class.create(name: 'Sample Event', county: county1, start_time: 1.day.from_now,
                             end_time: 2.days.from_now)
    end

    it 'returns a hash of county names and ids for the state of the event' do
      expect(event.county_names_by_id).to eq({ 'County 1' => county1.id, 'County 2' => county2.id })
    end

    it 'returns an empty hash if county is nil' do
      event.county = nil
      expect(event.county_names_by_id).to eq({})
    end
  end
end
