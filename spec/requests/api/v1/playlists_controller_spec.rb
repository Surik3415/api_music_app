# frozen_string_literal: true

RSpec.describe 'Api::V1::PlaylistsController', :request do
  let(:user) { create(:user) }
  let(:playlist) { create(:playlist) }

  describe 'GET #index public playlists' do
    path '/api/v1/playlists' do
      get 'Playlists #index endpoint' do
        tags 'Playlists'
        security [Bearer: []]

        context 'when user is authorized' do
          response(200, 'return ok') do
            run_test!
          end
        end
      end
    end
  end

  describe 'POST #create Playlist' do
    path '/api/v1/playlists' do
      post 'Playlists #create endpoint' do
        tags 'Playlists'
        consumes 'application/json'
        security [Bearer: []]
        parameter name: access_header, in: :header, type: :string
        parameter name: :params, in: :body, schema: {
          type: :object,
          properties: {
            id: { type: :string },
            name: { type: :string },
            description: { type: :string },
            logo: { type: :string }
          },
          required: %i[name]
        }

        context 'when user is owner of playlist' do
          let(access_header) { access_token(user) }
          let(:params) { { name: 'Payasos', description: 'Adios' } }

          response(200, 'return ok') do
            run_test!
          end
        end

        context 'with invalid updates' do
          let(access_header) { access_token(user) }
          let(:params) { { name: '22' } }
          let(:playlist_id) { create(:playlist, user: user).id }

          response(422, 'unprocessable_entity') do
            run_test!
          end
        end
      end
    end
  end

  describe 'SHOW #show Playlist' do
    path '/api/v1/playlists/{playlist_id}' do
      parameter name: 'playlist_id', in: :path, type: :string, description: 'Playlists ID'
      get 'Playlists #show endpoint' do
        tags 'Playlists'
        security [Bearer: []]
        parameter name: access_header, in: :header, type: :string

        context 'when user is owner of playlist' do
          let(:playlist) { create(:playlist) }
          let(access_header) { access_token(playlist.user) }
          let(:playlist_id) { playlist.id }

          response(200, 'return ok') do
            run_test!
          end
        end

        context 'when user view public playlist' do
          let(access_header) { access_token(user) }
          let(:playlist_id) { create(:playlist, access_type: :public).id }

          response(200, 'return ok') do
            include_context 'test with schema matcher' do
              let(:schema_path) { 'playlists/show' }
            end
          end
        end
      end
    end
  end

  describe 'PUT #update Playlist' do
    path '/api/v1/playlists/{playlist_id}' do
      parameter name: 'playlist_id', in: :path, type: :string, description: 'Playlists ID'
      put 'Playlists #update endpoint' do
        tags 'Playlists'
        consumes 'application/json'
        security [Bearer: []]
        parameter name: access_header, in: :header, type: :string
        parameter name: :params, in: :body, schema: {
          type: :object,
          properties: {
            id: { type: :string },
            name: { type: :string },
            description: { type: :string },
            logo: { type: :string }
          },
          required: %i[name]
        }

        context 'when user is owner of playlist' do
          let(access_header) { access_token(user) }
          let(:params) { { name: 'Payasos' } }
          let(:playlist_id) { create(:playlist, user: user).id }

          response(200, 'return ok') do
            run_test!
          end
        end

        context 'with invalid updates' do
          let(access_header) { access_token(user) }
          let(:params) { { name: '22' } }
          let(:playlist_id) { create(:playlist, user: user).id }

          response(422, 'unprocessable_entity') do
            run_test!
          end
        end
      end
    end
  end

  describe 'DELETE #destroy Playlist' do
    path '/api/v1/playlists/{playlist_id}' do
      parameter name: 'playlist_id', in: :path, type: :string, description: 'Playlist id'

      delete 'Playlist #show endpoint' do
        tags 'Playlist'
        security [Bearer: []]
        consumes 'application/json'
        parameter name: access_header, in: :header, type: :string

        context 'with valid params' do
          let(:playlist) { create(:playlist) }
          let(access_header) { access_token(playlist.user) }
          let(:playlist_id) { playlist.id }

          response(204, 'ok') do
            run_test!
          end
        end
      end
    end
  end
end
