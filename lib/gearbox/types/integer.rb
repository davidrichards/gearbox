module Gearbox::Types

  ##
  # A {Gearbox::Type} for integer values.  Values will be associated with the
  # `XSD.integer` type.
  #
  # A {Gearbox::Resource} property can reference this type as
  # `Gearbox::Types::Integer`, `Integer`, or `XSD.integer`.
  #
  # @see Gearbox::Type
  # @see http://rdf.rubyforge.org/RDF/Literal.html
  class Integer

    include Gearbox::Type

    def self.unserialize(value)
      value.object
    end

    def self.serialize(value)
      RDF::Literal.new(value)
    end

    register_alias XSD.integer

  end
end
