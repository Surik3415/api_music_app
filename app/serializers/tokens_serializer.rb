# frozen_string_literal: true

class TokensSerializer
  attr_reader :tokens

  def initialize(**tokens)
    @tokens = only_access_and_refresh(tokens)
  end

  private

  def only_access_and_refresh(tokens)
    {
      access: tokens[:access],
      refresh: tokens[:refresh]
    }
  end
end
