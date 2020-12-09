require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'SIGN UP /auth/registration' do
    let(:valid_attributes) do
      {
        auth: {
          name: 'Bob Bar',
          email: 'bob.bar@repap.com',
          phone: '+23769520125',
          password: 'bobbar',
          password_confirmation: 'bobbar'
        }
      }
    end
    let(:invalid_attributes) do
      {
        auth: {
          name: 'Bob Bar',
          email: 'bob.bar@repap.com',
          password_confirmation: 'bobbar'
        }
      }
    end

    context 'when request attributes are valid' do
      before { post '/auth/registration', params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when an invalid parameters' do
      before { post '/auth/registration', params: invalid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(:not_acceptable)
      end
    end
  end

  describe 'Auto Login ' do
    let(:user) { create(:user) }
    let(:valid_headers) { { 'Authorization' => token_generator(user) } }
    let(:invalid_headers) { { 'Authorization' => 'Bearer ' } }

    context 'when valid request' do
      before { get '/auth/auto_login', headers: valid_headers }

      it 'returns user object' do
        expect(response.body).to eq(user.to_json)
      end
    end

    context 'when invalid request' do
      context 'when missing token' do
        before { get '/auth/auto_login', headers: invalid_headers }

        it 'raises an error' do
          expect(response.body).to eq({ errors: 'No user logged in' }.to_json)
        end
      end
    end
  end
end
