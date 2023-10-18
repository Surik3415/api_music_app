# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Signups', type: :request do
  describe 'GET /create' do
    it 'returns http success' do
      get '/signup/create'
      expect(response.has_http_status?(:success)).to be(true)
    end
  end
end
