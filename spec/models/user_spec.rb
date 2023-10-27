# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has the has_secure_password method' do
    user = described_class.new
    expect(user.respond_to?(:authenticate)).to be(true)
  end
end
