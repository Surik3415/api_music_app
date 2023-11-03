# frozen_string_literal: true

module Api
  module V1
    class SigninController < AuthenticateController
      before_action :authorize_by_refresh_header!, only: %i[destroy]

      def create
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
          payload = { user_id: user.id }
          session = JWTSessions::Session.new(payload: payload)
          tokens = session.login
          render json: TokensSerializer.new(**tokens)
        else
          render json: ErrorsSerializer.new(message: 'invalid login or passwors'),
                 status: :unprocessable_entity
        end
      end

      def destroy
        session = JWTSessions::Session.new
        session.flush_by_token(found_token)

        render json: :ok
      end
    end
  end
end
