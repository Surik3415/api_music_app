# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Ping', type: :request do
  path '/' do
    get 'Check if the server is alive' do
      produces 'application/json'

      response '200', 'Server is alive' do
        run_test!
      end
    end
  end
end
