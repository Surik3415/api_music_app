# frozen_string_literal: true

RSpec.describe 'Api::V1::FriendRequestsController', :request do
  let(:current_user) { create(:user) }
  let(:friend) { create(:user) }
  let(:friend_request) { create(:friend_request, sender: current_user, receiver: friend) }

  describe 'POST #create friend request' do
    path '/api/v1/friend_requests' do
      post 'FriendRequest create endpoint' do
        tags 'FriendRequest'
        security [Bearer: []]
        consumes 'application/json'
        parameter name: access_header, in: :header, type: :string
        parameter name: :params, in: :body, schema: {
          type: :object,
          properties: {
            email: { type: :string }
          }
        }

        context 'with valid params' do
          let(:params) { { email: friend.email } }
          let(access_header) { access_token(current_user) }

          response(200, 'success') do
            run_test!
          end
        end

        context 'with invalid params' do
          let(:params) { ' ' }
          let(access_header) { access_token(current_user) }

          response(404, 'not found') do
            run_test!
          end
        end

        context 'try pu create it twice' do
          let(:params) { { email: friend.email } }
          let(access_header) { access_token(current_user) }

          before { create(:friend_request, sender: current_user, receiver: friend) }

          response(404, 'not found') do
            run_test!
          end
        end
      end
    end
  end

  describe 'GET #index friend request' do
    path '/api/v1/friend_requests/{tab}' do
      parameter name: 'tab', in: :path, type: :string, description: 'Tab'

      get 'received friend requests endpoint' do
        tags 'FriendRequest'
        security [Bearer: []]
        consumes 'application/json'
        parameter name: access_header, in: :header, type: :string

        context 'with valid params' do
          let(access_header) { access_token(friend) }
          let(:tab) { 'received' }

          before { friend_request }

          response(200, 'return ok') do
            include_context 'test with schema matcher' do
              let(:schema_path) { 'friend_requests/index_received_requests' }
            end
          end
        end
      end
    end
  end

  describe 'GET #index request' do
    path '/api/v1/friend_requests/{tab}' do
      parameter name: 'tab', in: :path, type: :string, description: 'Tab'

      get 'received friend requests endpoint' do
        tags 'FriendRequest'
        security [Bearer: []]
        consumes 'application/json'
        parameter name: access_header, in: :header, type: :string

        context 'with valid params' do
          let(access_header) { access_token(friend) }
          let(:tab) { 'sent' }

          before { friend_request }

          response(200, 'return ok') do
            include_context 'test with schema matcher' do
              let(:schema_path) { 'friend_requests/index_sent_requests' }
            end
          end
        end
      end
    end
  end
end
