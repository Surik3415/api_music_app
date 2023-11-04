# frozen_string_literal: true

RSpec.describe Author, type: :model do
  describe 'relations' do
    it {  is_expected.to have_many(:song_authors) }
    it {  is_expected.to have_many(:songs).through(:song_authors) }
    it {  is_expected.to have_many(:album_authors) }
    it {  is_expected.to have_many(:albums).through(:album_authors) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
