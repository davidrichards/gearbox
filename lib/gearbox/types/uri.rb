module Gearbox::Types

  ##
  # This type takes RDF Resource objects and provides RDF::URI objects for the
  # ruby representation.
  #
  # @see Gearbox::Type
  # @see http://rdf.rubyforge.org/RDF/URI.html
  class URI

    include Gearbox::Type

    def self.unserialize(value)
      RDF::URI(value)
    end

    def self.serialize(value)
      RDF::URI(value)
    end

    register_alias :uri
    register_alias RDF::URI

  end
end
