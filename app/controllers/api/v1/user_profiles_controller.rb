# frozen_string_literal: true

module Api
  module V1
    class UserProfilesController < AuthenticateController
      before_action :authorize_access_request!, only: %i[show destroy]

      def show
        render json: UsersSerializer.new(current_user), status: :ok
      end

      def update
        if current_user.update(user_params)
          return render json: UsersSerializer.new(current_user), status: :ok
        end

        render json: ErrorsSerializer.new(**current_user.errors), status: :unprocessable_entity
      end

      def destroy
        current_user.destroy
        head :no_content
      end

      private

      def user_params
        params.permit(:username, :email, :password, :image, :remove_image)
      end
    end
  end
end
