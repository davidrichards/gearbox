module Gearbox::Types

  ##
  # A {Gearbox::Type} for string values.  Values will be associated with the
  # `XSD.string` type with no language code.
  #
  # A {Gearbox::Resource} property can reference this type as
  # `Gearbox::Types::String`, `String`, or `XSD.string`.
  #
  # @see Gearbox::Type
  # @see http://rdf.rubyforge.org/RDF/Literal.html
  class String

    include Gearbox::Type

    def self.unserialize(value)
      value.object.to_s
    end

    def self.serialize(value)
      RDF::Literal.new(value.to_s)
    end

    register_alias XSD.string

  end
end
