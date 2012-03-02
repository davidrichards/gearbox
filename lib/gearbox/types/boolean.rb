module Gearbox::Types

  ##
  # A {Gearbox::Type} for Boolean values.  Values will be expressed as booleans
  # and packaged as `XSD.boolean` `RDF::Literal`s.
  #
  # A {Gearbox::Resource} property can reference this type as
  # `Gearbox::Types::Boolean`, `Boolean`, or `XSD.boolean`.
  #
  # @see Gearbox::Type
  # @see http://rdf.rubyforge.org/RDF/Literal.html
  class Boolean

    include Gearbox::Type

    def self.unserialize(value)
      value.object == true
    end

    def self.serialize(value)
      if value
        RDF::Literal.new(true, :datatype => XSD.boolean)
      else 
        RDF::Literal.new(false, :datatype => XSD.boolean)
      end
    end

    register_alias XSD.boolean

  end
end
