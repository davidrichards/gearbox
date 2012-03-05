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
    require_relative 'types/integer'
    require_relative 'types/boolean'
    require_relative 'types/any'
    require_relative 'types/string'
    require_relative 'types/float'
    require_relative 'types/uri'
    require_relative 'types/decimal'
    require_relative 'types/native'
    require_relative 'types/date'


  end
end
