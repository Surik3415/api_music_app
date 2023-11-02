# frozen_string_literal: true

RSpec.describe 'Api::V1::UserProfilesController', :request do
  let(:user) { create(:user) }

  describe 'GET show user_profile' do
    path '/api/v1/user_profile' do
      get 'UserProfile show endpoint' do
        tags 'User Profiles'
        security [Bearer: []]
        produces 'application/json'
        parameter name: access_header, in: :header, type: :string
        context 'when user is authorized' do
          let(access_header) { access_token(user) }

          response('200', 'return ok') do
            include_context 'test with schema matcher' do
              let(:schema_path) { 'user_profile/show' }
            end
          end
        end

        context 'when user is not authorized' do
          let(access_header) { '' }

          response(401, 'unauthorized') do
            run_test!
          end
        end
      end
    end
  end

  describe 'PUT #update' do
    path '/api/v1/user_profile' do
      put 'UserProfiles #update endpoint' do
        tags 'User Profiles'
        consumes 'application/json'
        security [Bearer: []]
        parameter name: access_header, in: :header, type: :string
        parameter name: :params, in: :body, schema: {
          type: :object,
          properties: {
            username: { type: :string },
            password: { type: :string },
            email: { type: :string },
            image: { type: :string }
          }
        }
        context 'with valid params' do
          let(access_header) { access_token(user) }
          let(:params) { { username: 'Valid' } }

          response(200, 'ok') do
            include_context 'test with schema matcher' do
              let(:schema_path) { 'user_profile/show' }
            end
          end
        end

        context 'with invalid params' do
          let(access_header) { access_token(user) }
          let(:params) { { username: '2', email: '2' } }

          response(422, 'unprocessable_entity') do
            include_context 'test with schema matcher' do
              let(:schema_path) { 'user_profile/unprocessable_entity' }
            end
          end
        end
      end
    end
  end

  describe 'PUT #destroy' do
    path '/api/v1/user_profile' do
      delete 'UserProfile update endpoint' do
        tags 'User Profiles'
        security [Bearer: []]
        produces 'application/json'
        parameter name: access_header, in: :header, type: :string

        context 'with valid params' do
          let(access_header) { access_token(user) }

          response('204', 'no_content') do
            run_test!
          end
        end
      end
    end
  end
end
