# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

# rubocop:disable RSpec/VerifiedDoubles
# rubocop:disable RSpec/ExampleLength
describe LoginController do
  describe 'before logged in' do
    it 'render the correct log in page' do
      get :login
      expect(response).to render_template('login')
    end

    it 'identify logged in user' do
      get :login, session: { current_user_id: 1 }
      expect(response).to redirect_to(user_profile_path)
    end
  end

  describe 'user log in' do
    before do
      allow(User).to receive(:providers).and_return({ google_oauth2: 1,
                                                      github:        2 })
      allow(User).to receive(:find_by).and_return(nil)
      allow(User).to receive(:create).and_return(double(id: 1))
    end

    it 'create nonexist user from GitHub API' do
      @fake_user_info = { 'uid' => 1, 'info' => { 'name'  => 'John Doe',
                                                  'email' => 'jdoe@some.add' }, 'provider' => 'github' }
      request.env['omniauth.auth'] = @fake_user_info
      get :github
      expect(User).to have_received(:create).with(
        uid:        1,
        provider:   2,
        first_name: 'John',
        last_name:  'Doe',
        email:      'jdoe@some.add'
      )
    end

    describe 'logged in via Google API' do
      before do
        @fake_user_info = { 'uid' => 1, 'info' => { 'first_name' => 'John',
          'last_name' => 'Doe', 'email' => 'jdoe@some.add' },
          'provider' => 'google_oauth2' }
        request.env['omniauth.auth'] = @fake_user_info
      end

      it 'create nonexist user' do
        get :google_oauth2
        expect(User).to have_received(:create).with(
          uid:        1,
          provider:   1,
          first_name: 'John',
          last_name:  'Doe',
          email:      'jdoe@some.add'
        )
      end

      it 'take user to the correct page after logged in' do
        get :google_oauth2, session: { destination_after_login: events_path }
        expect(response).to redirect_to(events_path)
      end

      it 'take user back to the root page if not specified' do
        get :google_oauth2
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'user log out' do
    before do
      get :logout, session: { current_user_id: 1 }
    end

    it 'clear session user id' do
      expect(session[:current_user_id]).to equal(nil)
    end

    it 'redirect to the root page' do
      expect(response).to redirect_to(root_path)
    end
  end
end
# rubocop:enable RSpec/VerifiedDoubles
# rubocop:enable RSpec/ExampleLength
