# frozen_string_literal: true

class AuthenticateController < ApplicationController
  include JWTSessions::RailsAuthorization
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

  private

  def current_user
    @current_user ||= User.find(payload['user_id'])
  end

  def not_authorized
    head(:unauthorized)
  end

  def not_found
    head(:not_found)
  end
end
