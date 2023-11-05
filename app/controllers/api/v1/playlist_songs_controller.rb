# frozen_string_literal: true

module Api
  module V1
    class PlaylistSongsController < AuthenticateController
      before_action :authorize_access_request!, only: %i[index create destroy]

      def create
        playlist = Playlist.find_by(id: palaylist_song_params[:playlist_id])
        song = Song.find_by(id: palaylist_song_params[:song_id])

        return not_found if playlist.nil? || !authorized_to_manage_playlist?(playlist) || song.nil?

        if not_same_song_exists_in_the_playlist?(playlist, song)
          add_and_render(playlist, song)
        else
          render json: { error: 'this song already in playlist' }, status: :conflict
        end
      end

      def destroy
        playlist = Playlist.find_by(id: params[:playlist_id])
        return not_found unless authorized_to_manage_playlist?(playlist)

        playlist_song = PlaylistSong.find_by(playlist_id: palaylist_song_params[:playlist_id],
                                             song_id: palaylist_song_params[:song_id])
        playlist_song.destroy
        head :no_content
      end

      private

      def add_and_render(playlist, song)
        playlist_song = PlaylistSong.new(playlist: playlist, song: song)
        playlist_song.save
        render json: PlaylistSongSerializer.new(playlist_song)
      end

      def palaylist_song_params
        params.permit(:song_id, :playlist_id)
      end

      def not_same_song_exists_in_the_playlist?(playlist, song)
        PlaylistSong.find_by(playlist: playlist, song: song).nil?
      end

      def authorized_to_manage_playlist?(playlist)
        return true if current_user.id == playlist.user_id

        if current_user.friends.include?(playlist.user_id) && playlist.sharable_type.open?
          return true
        end

        false
      end
    end
  end
end
