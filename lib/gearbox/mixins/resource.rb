module Gearbox
  ##
  # The main mixin for any model.  
  # TODO: include an example file.
  ##
  module Resource

    # ============
    # = Behavior =
    # ============
    def self.included(base)
      base.send :include, AdHocProperties
      base.send :include, SemanticAccessors
      base.send :include, RDF::Mutable
      base.send :include, RDF::Queryable
    end
    
    # Temporary!!
    def subject
      "http://example.com/z/#{id}"
    end
    
    # Depends on RDF::Queryable, SemanticAccessors and SubjectMethods
    def each(opts={}, &block)
      attribute_definitions.map{|name, attribute| attribute.to_rdf(self, opts)}.each(&block)
    end
    
  end
end
