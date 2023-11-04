# frozen_string_literal: true

RSpec.describe Genre, type: :model do
  describe 'relations' do
    it { is_expected.to have_many(:songs) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
