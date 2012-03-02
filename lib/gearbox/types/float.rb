module Gearbox::Types

  ##
  # A {Gearbox::Type} for Float values.  Values will be associated with the
  # `XSD.double` type.
  #
  # A {Gearbox::Resource} property can reference this type as
  # `Gearbox::Types::Float`, `Float`, `XSD.double`, or `XSD.float`.
  #
  # @see Gearbox::Type
  # @see http://rdf.rubyforge.org/RDF/Literal.html
  class Float

    include Gearbox::Type

    def self.unserialize(value)
      value.object.to_f
    end

    def self.serialize(value)
      RDF::Literal.new(value.to_f, :datatype => XSD.double)
    end

    register_alias XSD.float
    register_alias XSD.double

  end
end
