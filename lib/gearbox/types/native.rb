module Gearbox::Types

  ##
  # This type is a native type, doing no conversion to Ruby types.  The naked
  # RDF::Value (URI, Node, Literal, etc) will be used, and no deserialization
  # is done.
  #
  # @see Gearbox::Type
  class Native

    include Gearbox::Type

    def self.unserialize(value)
      value
    end

    def self.serialize(value)
      value
    end

  end
end
