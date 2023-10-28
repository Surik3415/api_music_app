# frozen_string_literal: true

RSpec.shared_context 'test with schema matcher' do
  run_test! do |response|
    expect(response).to match_json_schema(schema_path)
  end
end
