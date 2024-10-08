# frozen_string_literal: true

require 'rails_helper'
require 'google/apis/civicinfo_v2' # 'source we can use' https://googleapis.dev/ruby/google-api-client/latest/Google/Apis/CivicinfoV2/RepresentativeInfoResponse.html

RSpec.describe Representative, type: :model do
  describe 'mock representative params' do
    let(:mock_official) do
      instance_double(Google::Apis::CivicinfoV2::Official,
                      name:      'Mao',
                      address:   [
                        instance_double(Google::Apis::CivicinfoV2::SimpleAddressType,
                                        line1: '123 Main St',
                                        city:  'Anytown',
                                        state: 'CA',
                                        zip:   '12345')
                      ],
                      party:     'Commu',
                      photo_url: 'http:photo.jpg')
    end

    let(:mock_office) do
      instance_double(Google::Apis::CivicinfoV2::Office,
                      name:             'Senator',
                      division_id:      'ocd-division/country:us',
                      official_indices: [0])
    end

    let(:mock_api_response) do
      instance_double(Google::Apis::CivicinfoV2::RepresentativeInfoResponse,
                      officials: [mock_official],
                      offices:   [mock_office])
    end

    it 'creates one representative' do
      representatives = described_class.civic_api_to_representative_params(mock_api_response)
      expect(representatives.length).to eq(1)
    end

    context 'when the created representative' do
      let(:representative) { described_class.civic_api_to_representative_params(mock_api_response).first }

      it 'has the correct name' do
        expect(representative.name).to eq('Mao')
      end

      it 'has the correct ocdid' do
        expect(representative.ocdid).to eq('ocd-division/country:us')
      end

      it 'has the correct title' do
        expect(representative.title).to eq('Senator')
      end

      it 'has the correct contact address' do
        expect(representative.contact_address).to eq('123 Main St, Anytown, CA 12345')
      end

      it 'has the correct political party' do
        expect(representative.political_party).to eq('Commu')
      end

      it 'has the correct photo_url' do
        expect(representative.photo_url).to eq('http:photo.jpg')
      end
    end
  end

  # rubocop:disable RSpec/VerifiedDoubles
  # rubocop:disable RSpec/ExampleLength
  describe 'get information from Civic API' do
    before do
      @fake_rep = double('rep_info')
      @fake_official = double('official')
      @fake_office = double('office')
      allow(@fake_official).to receive(:name).and_return('John Doe')
      allow(@fake_official).to receive(:party).and_return('Democracy')
      allow(@fake_official).to receive(:photo_url).and_return('URL')
      allow(@fake_official).to receive(:address).and_return([double('Google::Apis::CivicinfoV2::SimpleAddressType',
                                                                    line1: '123 Main St', city: 'Anytown', state: 'CA',
                                                                    zip: '12345')])
      allow(@fake_office).to receive(:official_indices).and_return([0])
      allow(@fake_office).to receive(:name).and_return('Office Name')
      allow(@fake_office).to receive(:division_id).and_return('ID of the office')
      allow(@fake_rep).to receive(:officials).and_return([@fake_official])
      allow(@fake_rep).to receive(:offices).and_return([@fake_office])
      allow(described_class).to receive(:create!)
      @fake_record = double('record')
      allow(@fake_record).to receive(:update)
      allow(@fake_record).to receive(:save)
    end

    it 'adding items not in DB' do
      allow(described_class).to receive(:find_by!).and_raise(ActiveRecord::RecordNotFound)
      described_class.civic_api_to_representative_params(@fake_rep)
      expect(described_class).to have_received(:create!).with({ name: 'John Doe', ocdid: 'ID of the office',
        title: 'Office Name', contact_address: '123 Main St, Anytown, CA 12345', political_party: 'Democracy',
        photo_url: 'URL' })
    end

    it 'not adding items already in DB and update profile' do
      allow(described_class).to receive(:find_by!).and_return(@fake_record)
      described_class.civic_api_to_representative_params(@fake_rep)
      expect(described_class).not_to have_received(:create!).with({ name: 'John Doe', ocdid: 'ID of the office',
        title: 'Office Name', contact_address: '123 Main St, Anytown, CA 12345', political_party: 'Democracy',
        photo_url: 'URL' })
      expect(@fake_record).to have_received(:update).with({ name: 'John Doe', ocdid: 'ID of the office',
        title: 'Office Name', contact_address: '123 Main St, Anytown, CA 12345', political_party: 'Democracy',
        photo_url: 'URL' })
      expect(@fake_record).to have_received(:save)
    end
  end
  # rubocop:enable RSpec/VerifiedDoubles
  # rubocop:enable RSpec/ExampleLength
end
