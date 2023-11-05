# frozen_string_literal: true

RSpec.describe 'Api::V1::FriendshipsController', :request do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let!(:friend_request) { create(:friend_request, sender: user, receiver: user2) }

  describe 'POST #create friendships' do
    path '/api/v1/friendships' do
      post 'Friendships #create endpoint' do
        tags 'Friendships'
        security [Bearer: []]
        consumes 'application/json'
        parameter name: access_header, in: :header, type: :string
        parameter name: :params, in: :body, schema: {
          type: :object,
          properties: {
            id: { type: :string }
          }
        }

        context 'with valid params' do
          let(access_header) { access_token(user2) }
          let(:params) { { id: friend_request.id } }

          response(200, 'ok') do
            run_test!
          end
        end

        context 'when user is not authorized' do
          let(access_header) { '' }
          let(:params) { { id: friend_request.id } }

          response(401, 'unauthorized') do
            run_test!
          end
        end

        context 'when friendship already exists' do
          let(access_header) { access_token(user2) }
          let(:friend_request) { create(:friend_request, sender: user2, receiver: user) }
          let(:params) { { id: friend_request.id } }

          response(404, 'not_found') do
            let(:exists_friendship) { create(:friendship, user: user, friend: user2) }
            run_test!
          end
        end
      end
    end
  end

  describe 'GET #index friendship' do
    path '/api/v1/friendships' do
      get 'MyFriends #index endpoint' do
        tags 'MyFriends'
        security [Bearer: []]
        parameter name: access_header, in: :header, type: :string
        let(access_header) { access_token(user) }

        context 'when user is authorized' do
          response(200, 'return ok') do
            before { create(:friendship, user: user) }

            include_context 'test with schema matcher' do
              let(:schema_path) { 'friendship/ok' }
            end
          end
        end
      end
    end
  end

  describe 'DELETE #destroy friendships' do
    path '/api/v1/friendships/{friendship_id}' do
      parameter name: 'friendship_id', in: :path, type: :string, description: 'Friendship ID'

      delete 'Friendships #destroy endpoint' do
        tags 'Friendships'
        security [Bearer: []]
        consumes 'application/json'
        parameter name: access_header, in: :header, type: :string

        context 'with valid params' do
          let(access_header) { access_token(user2) }
          let(:friendship_id) { create(:friendship, user: user2).id }

          response(204, 'ok') do
            run_test!
          end
        end
      end
    end
  end
end
