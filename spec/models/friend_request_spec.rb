# frozen_string_literal: true

RSpec.describe FriendRequest, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:sender).class_name('User') }
    it { is_expected.to belong_to(:receiver).class_name('User') }
  end
end
