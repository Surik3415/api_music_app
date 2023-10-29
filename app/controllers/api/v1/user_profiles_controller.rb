# frozen_string_literal: true

module Api
  module V1
    class UserProfilesController < AuthenticateController
      before_action :authorize_access_request!, only: %i[show destroy]
      before_action :find_user_by_id, only: %i[show destroy update]

      def show
        render json: UsersSerializer.new(@user), status: :ok
      end

      def update
        return render json: UsersSerializer.new(@user), status: :ok if @user.update(user_params)

        render json: ErrorsSerializer.new(**@user.errors), status: :unprocessable_entity
      end

      def destroy
        @user.destroy
        head :no_content
      end

      private

      def user_params
        params.require(:user_profile).permit(:username, :email, :password, :image)
      end

      def find_user_by_id
        @user = User.find_by(id: current_user.id)
      end
    end
  end
end
