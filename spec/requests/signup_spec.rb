# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Signup', type: :request do
  describe 'POST /sign_up' do
    path '/sign_up' do
      post 'Creates a new user' do
        consumes 'application/json'
        parameter name: :params, in: :body, schema: {
          type: :object,
          properties: {
            username: { type: :string },
            email: { type: :string },
            password: { type: :string },
            password_confirmation: { type: :string }
          },
          required: %w[username email password password_confirmation]
        }
        context 'registrate user with valid params' do
          response(200, 'successful') do
            let(:params) { attributes_for(:user) }

            run_test!
          end
        end
      end
    end
  end
end
