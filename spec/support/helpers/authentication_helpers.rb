# frozen_string_literal: true

module Helpers
  module AuthenticationHelpers
    def token_by_user(user)
      payload = { user_id: user.id }
      tokens = JWTSessions::Session.new(payload: payload).login
      {
        JWTSessions.access_header => tokens[:access],
        JWTSessions.refresh_header => tokens[:refresh]
      }
    end

    def refresh_header
      JWTSessions.refresh_header
    end

    def access_header
      JWTSessions.access_header
    end

    def access_token(user)
      token_by_user(user)[access_header]
    end

    def refresh_token(user)
      token_by_user(user)[refresh_header]
    end
  end
end
