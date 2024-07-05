# frozen_string_literal: true

require 'gamefic'
require 'gamefic-standard'

require_relative "overlookable/version"

module Gamefic
  # A mixin for implementing nouns as Scenery with a default description.
  #
  module Overlookable
    # Create Scenery that provides a default description for unimplemented words.
    # Each element can either be a string for the entity's name or an array with
    # two strings to define a name and synonyms.
    #
    # @example
    #   thing = make Thing, name: 'table', description: 'A table with cups and white china plates.'
    #   thing.overlook 'cups', ['plates', 'white china']
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
    # @param names [String, Array(String, String)] Names or name/synonym arrays
    # @param type [Class<Entity>] The type of overlookable entity (default is Scenery)
    def overlook *names, type: Scenery
      names.map do |name|
        if name.is_a?(Array)
          type.new(name: name[0], synonyms: name[1], parent: self)
        else
          type.new(name: name, parent: self)
        end
      end
    end
  end
end

Gamefic::Entity.include Gamefic::Overlookable
