# frozen_string_literal: true

RSpec.describe ApplicationQuery do
  describe '.call' do
    it 'creates a new instance of ApplicationQuery and calls it' do
      query_instance = instance_double(described_class, call: nil)
      allow(described_class).to receive(:new).and_return(query_instance)
      expect(query_instance).to receive(:call)
      described_class.call
    end
  end
end
