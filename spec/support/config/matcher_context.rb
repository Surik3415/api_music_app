# frozen_string_literal: true

RSpec.shared_context 'test with schema matcher' do
  run_test! do |response|
    expect(response).to match_json_schema(schema_path)
  end
  after do |example|
    content = example.metadata[:response][:content] || {}
    example_spec = {
      'application/json' => {
        examples: {
          test_example: {
            value: JSON.parse(response.body, symbolize_names: true)
          }
        }
      }
    }
    example.metadata[:response][:content] = content.deep_merge(example_spec)
  end
end
