# frozen_string_literal: true

RSpec.describe 'Api::V1::PlaylistSongsController', :request do
  let(:user) { create(:user) }
  let(:playlist_song) { create(:song) }

  describe 'POST create playlist_songs' do
    path '/api/v1/playlist_songs' do
      post :create do
        tags 'PlaylistSongs'
        security [Bearer: []]
        consumes 'application/json'
        parameter name: access_header, in: :header, type: :string
        parameter name: :params, in: :body, schema: {
          type: :object,
          properties: {
            playlist_id: { type: :string },
            song_id: { type: :string }
          },
          required: %i[playlist_id song_id]
        }

        context 'when valid params' do
          let(access_header) { access_token(user) }
          let(:playlist_id) { create(:playlist, user: user).id }
          let(:song_id) { create(:song).id }
          let(:params) { { song_id: song_id, playlist_id: playlist_id } }

          response('200', 'ok') do
            run_test!
          end
        end
      end
    end
  end

  describe 'DELETE #destroy PlaylistSongs' do
    path '/api/v1/playlist_songs' do
      delete 'PlaylistSong #destroy endpoint' do
        tags 'PlaylistSong'
        security [Bearer: []]
        consumes 'application/json'
        parameter name: access_header, in: :header, type: :string
        parameter name: :params, in: :body, schema: {
          type: :object,
          properties: {
            playlist_id: { type: :string },
            song_id: { type: :string }
          },
          required: %i[playlist_id song_id]
        }

        context 'with valid params' do
          let(:playlist) { create(:playlist, user: user) }
          let(:song) { create(:song) }
          let(access_header) { access_token(playlist.user) }
          let(:playlist_song) { create(:playlist_song, playlist_id: playlist.id, song_id: song.id) }
          let(:params) do
            { song_id: playlist_song.song_id, playlist_id: playlist_song.playlist_id }
          end

          response(204, 'no content') do
            run_test!
          end
        end
      end
    end
  end
end
