# frozen_string_literal: true

RSpec.describe ImageUploader do
  let(:valid_image) { fixture_file_upload('images/media.png', 'image/png') }
  let(:user) { create(:user, image: valid_image) }
  let(:user_image) { user.image }

  it 'extracts metadata' do
    expect(user_image.mime_type).to eq('image/png')
    expect(user_image.extension).to eq('png')
    expect(user_image.size.instance_of?(Integer)).to be(true)
  end
end
