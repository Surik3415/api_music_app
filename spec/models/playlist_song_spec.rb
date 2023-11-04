# frozen_string_literal: true

RSpec.describe PlaylistSong, type: :model do
  describe 'relations' do
    it {  is_expected.to belong_to(:song) }
    it {  is_expected.to belong_to(:playlist) }
  end
end
