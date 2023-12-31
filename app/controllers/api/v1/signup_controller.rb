# frozen_string_literal: true

module Api
  module V1
    class SignupController < AuthenticateController
      def create
        user = User.new(user_params)

        if user.save
          payload = { user_id: user.id }
          session = JWTSessions::Session.new(payload: payload)
          tokens = session.login

          render json: TokensSerializer.new(**tokens)
        else
          render json: ErrorsSerializer.new(**user.errors), status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.permit(:email, :password, :password_confirmation, :username)
      end
    end
  end
end
