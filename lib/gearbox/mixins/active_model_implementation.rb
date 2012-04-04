module Gearbox
  
  # I wanted to have all of my ActiveModel mixins in one place.
  # I want to see how this is being used explicitly.
  module ActiveModelImplementation
    
    def self.included(base)
      base.send :include, ActiveModel::Validations
      base.send :include, ActiveModel::Conversion

      # This isn't right...so I need to research these things a little bit. 
      # What I'm thinking is a RESTful API isn't too much to ask from Gearbox, 
      # So I want these to produce JSON and XML in a consistent way...
      # I may be wrong, but I may be getting the RDF::JSON version here instead.
      base.send :include, ActiveModel::Serializers::JSON
      base.send :include, ActiveModel::Serializers::Xml
      
      base.send :extend, ActiveModel::Naming
      base.send :include, ActiveModel::Dirty
    end
    
    # TODO Temporary!!! Remove after finishing the Mutable changes.
    def persisted?
      false
    end
    
  end
end
