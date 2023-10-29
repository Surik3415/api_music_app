# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'validates username' do
    it { expect(user).not_to allow_value('1nvalid username').for(:username) }
    it { expect(user).to allow_value(user.username).for(:username) }
    it { is_expected.to validate_presence_of(:username) }
  end

  describe 'validates email' do
    it { expect(user).not_to allow_value('invalid_email').for(:email) }
    it { expect(user).to allow_value(user.email).for(:email) }
    it { is_expected.to validate_presence_of(:email) }
  end

  describe 'validates password' do
    it { is_expected.to have_secure_password }
    it { expect(user).to allow_value(user.password).for(:password) }
    it { expect(user).not_to allow_value(' ').for(:password) }
  end
end
