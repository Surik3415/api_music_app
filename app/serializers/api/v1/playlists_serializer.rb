# frozen_string_literal: true

module Api
  module V1
    class PlaylistsSerializer < ApplicationSerializer
      attributes :name, :description, :likes, :created_at, :updated_at

      attribute :logo, &:logo_url
    end
  end
end
