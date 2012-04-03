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
      # Rethinking this one, they will be much more robust soon.
      # This is more for knowledge base discovery or throw-away models
      # So there's a new approach on the horizon of my imagination.
      # base.send :include, AdHocProperties
      base.send :include, SubjectMethods
      base.send :include, SemanticAccessors
      base.send :include, ActiveModelImplementation
      base.send :include, RDF::Mutable
      base.send :include, RDF::Queryable
    end
    
    # Depends on RDF::Queryable, SemanticAccessors and SubjectMethods
    def each(opts={}, &block)
      attribute_definitions.map{|name, attribute| attribute.to_rdf(self, opts)}.each(&block)
    end
    
    def inspect
      "#{self.class.name} #{self.attributes.inspect}"
    end
    
  end
end
