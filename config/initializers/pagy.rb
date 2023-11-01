# frozen_string_literal: true

# config/initializers/pagy.rb
require 'pagy/extras/metadata'
require 'pagy/extras/overflow'

Pagy::DEFAULT[:overflow] = :empty_page
Pagy::DEFAULT[:metadata] = %i[scaffold_url count page prev next]
