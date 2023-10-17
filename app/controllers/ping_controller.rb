# frozen_string_literal: true

class PingController < ApplicationController
  def index
    render json: { connect: 'great seccusses' }
  end
end
