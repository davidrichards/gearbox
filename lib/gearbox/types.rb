module Gearbox

  ##
  # Gearbox::Types is a set of default Gearbox::Type classes.
  #
  # @see Gearbox::Type
  # @see Gearbox::Types::Integer
  # @see Gearbox::Types::Boolean
  # @see Gearbox::Types::String
  # @see Gearbox::Types::Float
  # @see Gearbox::Types::Any
  module Types

    # No autoloading here--the associations to XSD types are made by the
    # classes themselves, so we need to explicitly require them or XSD types
    # will show up as not found.
    require 'gearbox/types/integer'
    require 'gearbox/types/boolean'
    require 'gearbox/types/any'
    require 'gearbox/types/string'
    require 'gearbox/types/float'
    require 'gearbox/types/uri'
    require 'gearbox/types/decimal'
    require 'gearbox/types/native'


  end
end
