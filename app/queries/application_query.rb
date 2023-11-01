# frozen_string_literal: true

class ApplicationQuery
  def initialize(_object = {}, options = {})
    @options = options
  end

  def self.call(options = {})
    new(options).call
  end

  def call; end
end
