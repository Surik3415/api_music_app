# frozen_string_literal: true

RSpec.describe Album, type: :model do
  describe 'relations' do
    it {  is_expected.to have_many(:album_authors) }
    it {  is_expected.to have_many(:authors).through(:album_authors) }
    it {  is_expected.to have_many(:songs) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
