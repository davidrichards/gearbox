# ================
# = Dependencies =
# ================
require 'uuid'
require 'linkeddata'
require 'ostruct'

module Gearbox
  
  # ========================
  # = Helper Utility: path =
  # ========================
  def path(path)
    File.expand_path("../gearbox/#{path}", __FILE__)
  end
  private :path
  module_function :path
  
  # =======================
  # = Loading the Library =
  # =======================
  autoload :AttributeCollection, path('attribute_collection')
  autoload :RDFCollection, path('rdf_collection')

  autoload :AdHocProperties, path('mixins/ad_hoc_properties')
  autoload :Resource, path('mixins/resource')
  autoload :SemanticAccessors, path('mixins/semantic_accessors')
  
  # ============
  # = Examples =
  # ============
  
  # Will separate these after things get to a solid 0.1 state.
  autoload :Audience, path('../examples/audience')
  autoload :Person, path('../examples/person')
  autoload :Reference, path('../examples/reference')
  autoload :Theme, path('../examples/theme')
  
end
