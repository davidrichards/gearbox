module Gearbox
  ##
  # Allows a model instance to add a new property at runtime.  
  # This is a (small) tip of the hat towards the flexibility
  # offered by using a graph instead of a schema to govern
  # the data store.  
  ##
  module AdHocProperties

    # Getter and setter for an id property.
    # Will be adjusted when I decide whether to mixin ActiveModel
    attr_accessor :id
    
    # Stored attributes
    # @return [RDFCollection]
    def attributes_list
      @attributes_list ||= RDFCollection.new
    end
    
    # Generates or gets a blank node, based on the id.
    # Will be replaced by subject.
    # @return [RDF::Node] 
    def bnode
      return @bnode if @bnode
      self.id ||= UUID.generate
      safe_id = "#{self.class.name}_#{id}".gsub(/[^A-Za-z0-9\-_]/, '_')
      @bnode = RDF::Node(safe_id)
    end
    
    # Add a property without defining it on the class.
    # This will stay, will use the subject, and the regular infrastructure.
    # @param [Symbol] accessor, the new field being created.
    # @param [RDF::Statement] predicate, the predicate for the new field.
    # @param [Any] The value to store
    def add_property(accessor, predicate, object)
      new_property = RDF::Statement.new(bnode, predicate, object)
      attributes_list[accessor] = new_property
    end
    
  end
end
