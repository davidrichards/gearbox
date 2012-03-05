module Example
  class Audience
    
    attr_writer :resource_source

    attr_accessor :name
    
    def add_resource(hash={})
      new_resource = resource_source.call(hash.merge(:audience => self))
      resources << new_resource
      new_resource
    end
    
    def resources
      @resources ||= []
    end
    
    private
      def resource_source
        @resource_source ||= Resource.public_method(:new)
      end
      
  end
end
