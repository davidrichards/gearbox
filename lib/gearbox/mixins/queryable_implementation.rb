module Gearbox
  module QueryableImplementation
    def self.included(base)
      base.send :include, RDF::Queryable
    end
    
    # Depends on RDF::Queryable, SemanticAccessors and SubjectMethods
    def each(opts={}, &block)
      attribute_definitions.map{|name, attribute| attribute.to_rdf(self, opts)}.each(&block)
    end
    alias :each_statement :each
    
  end
end
