# frozen_string_literal: true

class ApplicationQuery
  def self.call(options = {})
    new(options).call
  end

  def initialize(_object = {}, options = {})
    @options = options
  end

  def call; end
end
