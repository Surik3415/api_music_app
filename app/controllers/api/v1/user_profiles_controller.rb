# frozen_string_literal: true

module Api
  module V1
    class UserProfilesController < AuthenticateController
      before_action :authorize_refresh_request!, only: :destroy
      before_action :authorize_access_request!, only: :show
      before_action :find_user_by_id, only: %i[show destroy update]

      def show
        render json: UsersSerializer.new(@user), status: :ok
      end

      def update
        @user.update(user_params)

        render json: UsersSerializer.new(@user), status: :ok
      end

      def destroy
        @user.delete

        head :no_content
      end

      private

      def user_params
        params.permit(:username, :email, :password)
      end

      def find_user_by_id
        @user = User.find_by(id: current_user.id)
      end
    end
  end
end
