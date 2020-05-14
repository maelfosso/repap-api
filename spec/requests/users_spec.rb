require 'rails_helper'

RSpec.describe 'Users API', type: :request do

  describe 'SIGN UP /auth/registration' do 
    let (:valid_attributes) {
      { 
        :auth => {
          :name => "Bob Bar",
          :email => "bob.bar@repap.com",
          :phone => "+23769520125",
          :password => "bobbar",
          :password_confirmation => "bobbar"
        }
      }
    }
    let (:invalid_attributes) {
      { 
        :auth => {
          :name => "Bob Bar",
          :email => "bob.bar@repap.com",
          :password_confirmation => "bobbar"
        }
      }
    }

    context 'when request attributes are valid' do
      before { post "/auth/registration", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when an invalid parameters' do 
      before { post "/auth/registration", params: invalid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(:not_acceptable)
      end
    end 
  end


end