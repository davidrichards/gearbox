module Gearbox
  
  # I wanted to have all of my ActiveModel mixins in one place.
  # I want to see how this is being used explicitly.
  module ActiveModelImplementation
    
    def self.included(base)
      base.send :include, ActiveModel::Validations
      base.send :include, ActiveModel::Conversion
      base.send :extend, ActiveModel::Naming
    end
    
    # TODO Temporary!!! Remove after finishing the Mutable changes.
    def persisted?
      false
    end
    
  end
end
