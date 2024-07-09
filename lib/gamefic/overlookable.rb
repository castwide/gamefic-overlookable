# frozen_string_literal: true

require 'gamefic'
require 'gamefic-standard'

require_relative 'overlookable/version'

module Gamefic
  # A mixin for implementing nouns as Scenery with a default description.
  #
  module Overlookable
    # Create Scenery that provides a default description for unimplemented words.
    # Names can include two slashes (//) to add a list of synonyms.
    #
    # The type of overlookable entity can be modified with the `type` parameter.
    # For compatibility with the gamefic-standard library, it is recommended to
    # use either `Scenery` or `Rubble`.
    #
    # @example
    #   thing = make Thing, name: 'table', description: 'A table with cups and white china plates.'
    #   thing.overlook 'cups', 'plates//white china'
    #
    #   # > look table
    #   #
    #   # A table with cups and white china plates.
    #   #
    #   # > look cups
    #   #
    #   # There's nothing special about the cups.
    #   #
    #   # > look china
    #   #
    #   # There's nothing special about the plates.
    #
    # @param names [Array<String>] Names or name/synonym arrays
    # @param type [Class<Entity>] The type of overlookable entity (default is Scenery)
    # @return [Array<Entity>]
    def overlook *names, type: Scenery
      names.map do |input|
        parts = input.split('//')
        name = parts[0].to_s.strip
        synonyms = parts[1].to_s.strip
        type.new(name: name, synonyms: synonyms, parent: self)
      end
    end

    # A shortcut to overlookable Scenery that can be called from `make` parameters.
    #
    # @example
    #   make Thing, name: 'table',
    #               description: 'A table with a checkered design.',
    #               scenery: ['checkered design']
    #
    # @param [Array<String>]
    # @return [void]
    def scenery= names
      overlook(*names, type: Scenery)
    end

    # A shortcut to overlookable Rubble that can be called from `make` parameters.
    #
    # @example
    #   make Thing, name: 'table',
    #               description: 'A table with a plate on it.',
    #               rubble: ['plate']
    #
    # @param [Array<String>]
    # @return [void]
    def rubble= names
      overlook(*names, type: Rubble)
    end
  end
end

Gamefic::Entity.include Gamefic::Overlookable
