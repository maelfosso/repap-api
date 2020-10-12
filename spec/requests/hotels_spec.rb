require 'rails_helper'

RSpec.describe 'Hotels API', type: :request do

  let (:valid_attributes) {
    {
      :name => "FEUGIF HOTEL",
      :phone => "+237232456851",
      :price => 15000,
      :address => "Melen",
      :infos => "a nice hotel",
      :latlng => "3.1452, 11.2343",
    }
  }
  let (:user) { create(:user) }
  let (:valid_headers) {{ 'Authorization' => token_generator(user) }}
  let (:invalid_headers) {{ 'Authorization' => "Bearer " }}


  describe 'POST: CREATE HOTEL' do
    let (:invalid_attributes) {
      { 
        :name => "FEUGIFF HOTEL",
        :address => "Melen",
        :phone => "675849126"
      }
    }

    context 'when request attributes are valid' do
      before {  post "/hotels", params: valid_attributes, headers: valid_headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when request attributes are invalid, not acceptable results' do
      before {  post "/hotels", params: invalid_attributes, headers: valid_headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(:not_acceptable)
      end
    end

    context 'when headers is invalid, :unauthorized result' do
      before {  post "/hotels", params: valid_attributes, headers: invalid_headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

  end

  describe 'GET HOTELS ' do

    context 'at the beginning' do
      before { get "/hotels", headers: valid_headers } 

      it 'returns user object' do
        json_response = JSON.parse(response.body)
        expect(json_response).to eq([])
      end
    end

    context 'when one hotel is saved' do
      before {  post "/hotels", params: valid_attributes, headers: valid_headers }

      it 'returns an array of length 1' do
        get "/hotels", headers: valid_headers
        json_response = JSON.parse(response.body)

        expect(json_response.length).to eq(1)
      end
    end

  end 

end