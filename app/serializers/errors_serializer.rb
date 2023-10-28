# frozen_string_literal: true

class ErrorsSerializer
  attr_reader :errors

  def initialize(**errors)
    @errors = errors
  end
end
