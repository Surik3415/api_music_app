# frozen_string_literal: true

RSpec.describe 'AuthenticationHelpers' do
  let(:user) { create(:user) }
  let(:session_class) { JWTSessions }

  describe '#refresh_header' do
    it 'returns the refresh header name' do
      expect(refresh_header.is_a?(String)).to be(true)
    end
  end

  describe '#access_header' do
    it 'returns the access header name' do
      expect(access_header.is_a?(String)).to be(true)
    end
  end

  describe '#refresh_token' do
    it 'returns the refresh token for a user' do
      refresh_token = refresh_token(user)
      expect(refresh_token.is_a?(String)).to be(true)
    end
  end

  describe '#access_token' do
    it 'returns the refresh token for a user' do
      access_token = access_token(user)
      expect(access_token.is_a?(String)).to be(true)
    end
  end
end
