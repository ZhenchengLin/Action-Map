# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { described_class.create(uid: 'ABC123', provider: :google_oauth2, first_name: 'John', last_name: 'Doe') }

    it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider) }
  end

  # Enum tests
  it { is_expected.to define_enum_for(:provider).with_values(google_oauth2: 1, github: 2).with_prefix(:provider) }

  # Instance method tests
  describe '#name' do
    it 'returns the full name of the user' do
      user = described_class.new(first_name: 'John', last_name: 'Doe')
      expect(user.name).to eq('John Doe')
    end
  end

  describe '#auth_provider' do
    it 'returns the correct auth provider name' do
      user = described_class.new(provider: 'google_oauth2')
      expect(user.auth_provider).to eq('Google')

      user.provider = 'github'
      expect(user.auth_provider).to eq('Github')
    end
  end

  # Shared examples for find_user_by_provider
  shared_examples 'find_user_by_provider' do |method, uid, provider|
    let!(:user) { described_class.create(uid: uid, provider: provider, first_name: 'John', last_name: 'Doe') }

    it "returns the user with the given uid and #{provider} provider" do
      expect(described_class.send(method, uid)).to eq(user)
    end

    it "returns nil if no user is found with the given uid and #{provider} provider" do
      expect(described_class.send(method, 'nonexistent_uid')).to be_nil
    end
  end

  # Class method tests
  describe '.find_google_user' do
    it_behaves_like 'find_user_by_provider', :find_google_user, 'ABC123', :google_oauth2
  end

  describe '.find_github_user' do
    it_behaves_like 'find_user_by_provider', :find_github_user, 'DEF456', :github
  end
end
