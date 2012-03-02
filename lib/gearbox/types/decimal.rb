require 'bigdecimal'

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
  class Decimal
    include Gearbox::Type

    def self.unserialize(value)
      object = value.object
      object.is_a?(BigDecimal) ? object : BigDecimal.new(object.to_s)
    end

    def self.serialize(value)
      RDF::Literal.new(value.is_a?(BigDecimal) ? value.to_s('F') : value.to_s, :datatype => XSD.decimal)
    end

    register_alias XSD.decimal

  end
end
