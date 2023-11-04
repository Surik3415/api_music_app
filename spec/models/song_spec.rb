# frozen_string_literal: true

RSpec.describe Song, type: :model do
  describe 'relations' do
    it { is_expected.to have_many(:song_authors) }
    it { is_expected.to have_many(:authors).through(:song_authors) }
    it { is_expected.to belong_to(:genre) }
    it { is_expected.to belong_to(:album) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
