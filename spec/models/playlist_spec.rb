# frozen_string_literal: true

RSpec.describe Playlist, type: :model do
  let(:user) { create(:user) }
  let(:playlist) { build(:playlist) }

  it 'is valid with valid attributes' do
    expect(playlist.valid?).to be(true)
  end

  it 'is not valid without a name' do
    playlist.name = nil
    expect(playlist.valid?).to be(false)
  end

  it 'is not valid with a name shorter than 3 characters' do
    playlist.name = String.new('A' * 2)
    expect(playlist.valid?).to be(false)
  end

  it 'is not valid with a name longer than 50 characters' do
    playlist = build(:playlist, user: user, name: 'A' * 51)
    expect(playlist.valid?).to be(false)
  end

  it 'is valid with a description shorter than 3 characters' do
    playlist = build(:playlist, user: user, description: 'Aa')
    expect(playlist.valid?).to be(false)
  end

  it 'is not valid with a description longer than 250 characters' do
    playlist = build(:playlist, user: user, description: 'A' * 251)
    expect(playlist.valid?).to be(false)
  end
end
