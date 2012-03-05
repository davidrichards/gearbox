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
    
  end
end
