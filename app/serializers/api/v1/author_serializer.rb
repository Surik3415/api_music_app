# frozen_string_literal: true

module Api
  module V1
    class AuthorSerializer < ApplicationSerializer
      attribute :author_name, &:name
    end
  end
end
