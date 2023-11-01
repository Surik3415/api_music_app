# frozen_string_literal: true

module Api
  module V1
    class PlaylistsController < AuthenticateController
      before_action :authorize_access_request!, only: %i[update destroy]

      include Pagy::Backend

      ITEMS = 10

      def index
        public_playlists = Playlist.access_type_public
        pagy, public_playlists = pagy(public_playlists, items: ITEMS)
        options = { meta: pagy_metadata(pagy) }

        render json: PlaylistsSerializer.new(public_playlists, options), status: :ok
      end

      def show
        playlist = Playlist.find_by(id: params[:id])
        return not_found if playlist.nil?
        return not_found unless authorized_to_view?(playlist)

        render json: PlaylistsSerializer.new(@playlist), status: :ok
      end

      def update
        playlist = current_user.playlists.find_by(id: params[:id])
        return not_found if playlist.nil?

        if playlist.update(playlist_params)
          render json: PlaylistsSerializer.new(playlist), status: :ok
        else
          render json: ErrorsSerializer.new(**playlist.errors.messages), status: :ok
        end
      end

      def destroy
        playlist = current_user.playlists.find_by(id: params[:id])
        return not_found if playlist.nil?

        playlist.destroy
      end

      private

      def authorized_to_view?(playlist)
        return true if playlist.access_type_public?

        return false if current_user.nil?

        return current_user.friends.includes?(playlist.user) if playlist.access_type_only_friend?

        false
      end
    end
  end
end
