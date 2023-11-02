# frozen_string_literal: true

RSpec.describe 'Signin', type: :request do
  let(:user) { create(:user) }

  describe 'POST /sign_in' do
    path '/sign_in' do
      post 'Creates a session' do
        consumes 'application/json'
        parameter name: :params, in: :body, schema: {
          type: :object,
          properties: {
            email: { type: :string },
            password: { type: :string }
          }
        }

        context 'sign in with valid params' do
          response(200, 'successful') do
            let(:params) { { email: user.email, password: user.password } }

            include_context 'test with schema matcher' do
              let(:schema_path) { 'auth/ok_sign_in' }
            end
          end
        end

        context 'sign in with invalid password' do
          response(422, 'unprocessable_entity') do
            let(:params) { { email: user.email, password: ' ' } }

            run_test!
          end
        end

        context 'sign in with invalid email' do
          response(422, 'unprocessable_entity') do
            let(:params) { { email: ' ', password: user.password } }

            run_test!
          end
        end

        context 'sign in with invalid email and password' do
          response(422, 'unprocessable_entity') do
            let(:params) { { email: ' ', password: ' ' } }

            run_test!
          end
        end
      end
    end
  end

  describe 'DELETE sign_out' do
    path '/sign_out' do
      delete 'Destroy' do
        tags 'Sessions'
        security [Bearer: []]
        consumes 'application/json'
        parameter name: refresh_header, in: :header, type: :string

        context 'with valid authentication' do
          let(refresh_header) { refresh_token(user) }

          response(200, 'ok') do
            run_test!
          end
        end
      end
    end
  end
end
