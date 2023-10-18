# frozen_string_literal: true

class SigninController < ApplicationController
  before_action :authorize_by_refresh_header!, only: %i[destroy]

  def create
    user = User.find_by!(email: params[:email])
    if user.authenticate(params[:password])
      payload = { user_id: user.id }
      session = JWTSessions::Session.new(payload: payload)
      render json: session.login
    else
      head :not_found
    end
  end

  def destroy
    session = JWTSessions::Session.new
    tokens = session.login
    session.flush_by_token(tokens[:refresh])

    render json: :ok
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
