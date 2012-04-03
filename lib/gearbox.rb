# ================
# = Dependencies =
# ================
require 'linkeddata'
require 'ostruct'
require 'active_model'

module Gearbox
  
  # =======================
  # = Settings from Spira =
  # =======================
  ##
  # The list of repositories available for Gearbox resources
  #
  # @see http://rdf.rubyforge.org/RDF/Repository.html
  # @return [Hash{Symbol => RDF::Repository}]
  # @private
  def repositories
    settings[:repositories] ||= {}
  end
  module_function :repositories

  ##
  # The list of all property types available for Gearbox resources
  # 
  # @see Gearbox::Types
  # @return [Hash{Symbol => Gearbox::Type}]
  def types
    settings[:types] ||= {}
  end
  module_function :types

  ##
  # A thread-local hash for storing settings.  Used by Resource classes.
  #
  # @see Gearbox::Resource
  # @see Gearbox.repositories
  # @see Gearbox.types
  def settings
    Thread.current[:gearbox] ||= {}
  end
  module_function :settings

  ##
  # Add a repository to Gearbox's list of repositories.
  #
  # @overload add_repository(name, repo)
  #     @param [Symbol] name The name of this repository
  #     @param [RDF::Repository] repo An RDF::Repository
  # @overload add_repository(name, klass, *args)
  #     @param [Symbol] name The name of this repository
  #     @param [RDF::Repository, Class] repo A Class that inherits from RDF::Repository
  #     @param [*Object] The list of arguments to instantiate the class
  # @example Adding an ntriples file as a repository
  #     Gearbox.add_repository(:default, RDF::Repository.load('http://datagraph.org/jhacker/foaf.nt'))
  # @example Adding an empty repository to be instantiated on use
  #     Gearbox.add_repository(:default, RDF::Repository)
  # @return [Void]
  # @see RDF::Repository
  def add_repository(name, klass, *args)
    repositories[name] = case klass
      when Class
        promise { klass.new(*args) }
      else
        klass
     end
     if (name == :default) && settings[:repositories][name].nil?
        warn "WARNING: Adding nil default repository"
     end
  end
  alias_method :add_repository!, :add_repository
  module_function :add_repository, :add_repository!

  ##
  # The RDF::Repository for the named repository
  #
  # @param [Symbol] name The name of the repository
  # @return [RDF::Repository]
  # @see RDF::Repository
  def repository(name)
    repositories[name]
  end
  module_function :repository

  ##
  # Clear all repositories from Gearbox's knowledge.  Use it if you want, but
  # it's really here for testing.
  #
  # @return [Void]
  # @private
  def clear_repositories!
    settings[:repositories] = {}
  end
  module_function :clear_repositories!

  ##
  # Alias a property type to another.  This allows a range of options to be
  # specified for a property type which all reference one Gearbox::Type
  #
  # @param [Any] new The new symbol or reference
  # @param [Any] original The type the new symbol should refer to
  # @return [Void]
  # @private
  def type_alias(new, original)
    types[new] = original 
  end
  module_function :type_alias
  
  # ========================
  # = Helper Utility: path =
  # ========================
  # @private
  def path(path)
    File.expand_path("../gearbox/#{path}", __FILE__)
  end
  private :path
  module_function :path
  
  # =======================
  # = Loading the Library =
  # =======================
  require path('type')
  require path('types')
  autoload :Attribute, path('attribute')
  autoload :AttributeCollection, path('attribute_collection')
  autoload :RDFCollection, path('rdf_collection')

  autoload :AdHocProperties, path('mixins/ad_hoc_properties')
  autoload :AttributeMethods, path('mixins/attribute_methods')
  autoload :Resource, path('mixins/resource')
  autoload :SemanticAccessors, path('mixins/semantic_accessors')
  autoload :SubjectMethods, path('mixins/subject_methods')
  
end

module Example
  # ========================
  # = Helper Utility: path =
  # ========================
  # @private
  def path(path)
    File.expand_path("../examples/#{path}", __FILE__)
  end
  private :path
  module_function :path

  # ============
  # = Examples =
  # ============
  
  # Will separate these after things get to a solid 0.1 state.
  autoload :Audience, path('audience')
  autoload :Person, path('person')
  autoload :Reference, path('reference')
  autoload :Theme, path('theme')
  
end
