# frozen_string_literal: true

RSpec.describe SongAuthor, type: :model do
  describe 'relations' do
    it {  is_expected.to belong_to(:song) }
    it {  is_expected.to belong_to(:author) }
  end
end
