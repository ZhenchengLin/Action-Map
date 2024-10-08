# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepresentativesController, type: :controller do
  let(:representative1) do
    instance_double(Representative, id: 1, name: 'Mao', title: 'Senator', ocdid: 'ocd-division/country:us',
    political_party: 'Independent', contact_address: '123 Main St, Anytown, CA 12345', photo_url: 'http:photo.jpg')
  end
  let(:representative2) do
    instance_double(Representative, id: 2, name: 'Xi', title: 'Senator', ocdid: 'ocd-division/country:us',
   political_party: 'Independent', contact_address: '123 Main St, Anytown, CA 12345', photo_url: 'http:photo.jpg')
  end

  before do
    allow(Representative).to receive(:find).with('1').and_return(representative1)
    allow(Representative).to receive(:find).with('2').and_return(representative2)
  end

  it 'assigns the requested representative to @representative with find' do
    get :show, params: { id: '1' }
    expect(assigns(:representative)).to eq(representative1)
  end

  it 'renders show template' do
    get :show, params: { id: '1' }
    expect(response).to render_template(:show)
  end

  describe 'GET #index' do
    let(:all_representatives) { [representative1, representative2] }

    before do
      allow(Representative).to receive(:all).and_return(all_representatives)
      get :index
    end

    it 'assigns all representatives to @representatives' do
      expect(assigns(:representatives)).to eq(all_representatives)
    end

    it 'renders index template' do
      expect(response).to render_template(:index)
    end
  end
end
