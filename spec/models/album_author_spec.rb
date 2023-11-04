# frozen_string_literal: true

RSpec.describe AlbumAuthor, type: :model do
  describe 'relations' do
    it {  is_expected.to belong_to(:author) }
    it {  is_expected.to belong_to(:album) }
  end
end
