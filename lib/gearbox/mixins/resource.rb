module Gearbox
  ##
  # The main mixin for any model.  
  # TODO: include an example file.
  ##
  module Resource

    # ============
    # = Behavior =
    # ============
    include AdHocProperties
    include SemanticAccessors
    include RDF::Mutable
    include RDF::Queryable
    
  end
end
