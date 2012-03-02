module Gearbox::Types

  ##
  # A {Gearbox::Type} for Date values.  Values will be associated with the
  # `XSD.date` type.
  #
  # A {Gearbox::Resource} property can reference this type as
  # `Gearbox::Types::Date`, `Date`, or `XSD.Date`.
  #
  # @see Gearbox::Type
  # @see http://rdf.rubyforge.org/RDF/Literal.html
  class Date

    include Gearbox::Type

    def self.unserialize(value)
      value.object
    end

    def self.serialize(value)
      RDF::Literal::Date.new(value)
    end

    register_alias XSD.date

  end
end
