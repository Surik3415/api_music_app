# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FriendRequestTabs do
  it 'defines the RECEIVED constant' do
    expect(FriendRequestTabs::RECEIVED).to eq(:received)
  end

  it 'defines the SENT constant' do
    expect(FriendRequestTabs::SENT).to eq(:sent)
  end

  it 'defines the ALL constant as an array of both RECEIVED and SENT' do
    expect(FriendRequestTabs::ALL).to contain_exactly(FriendRequestTabs::RECEIVED,
                                                      FriendRequestTabs::SENT)
  end
end
