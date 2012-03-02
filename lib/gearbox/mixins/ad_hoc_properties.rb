module Gearbox
  module AdHocProperties

    attr_accessor :id
    
    def attributes_list
      @attributes_list ||= RDFCollection.new
    end
    
    def bnode
      return @bnode if @bnode
      self.id ||= UUID.generate
      safe_id = "#{self.class.name}_#{id}".gsub(/[^A-Za-z0-9\-_]/, '_')
      @bnode = RDF::Node(safe_id)
    end
    
    def add_property(accessor, predicate, object)
      new_property = RDF::Statement.new(bnode, predicate, object)
      attributes_list[accessor] = new_property
    end
    
  end
end
