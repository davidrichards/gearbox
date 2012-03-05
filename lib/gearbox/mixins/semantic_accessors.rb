module Gearbox
  
  ##
  # The attributes to add to a model.
  # TODO: Add example from file.
  ##
  module SemanticAccessors

    # Treat this as a bundle of class methods and instance methods.
    # @private
    def self.included(base)
      base.extend ClassMethods
      base.send :include, InstanceMethods
    end

    ##
    # Class methods for the model.
    ##
    module ClassMethods
      
      # Add an attribute or a field to a model.  Takes a field name.  
      # Defines both a getter and a setter on the object.
      # Requires a predicate option.  Options are:
      # * :predicate => RDF::URI
      # * :reverse => Boolean store as value, predicate, subject
      # * :index => Boolean maintain a full-text search index on this attribute
      # @param [String, Symbol] getter_name, the field that is being created.
      # @param [Hash] options
      def attribute(getter_name, options={})
        
        raise ArgumentError, "A predicate must be defined" unless options[:predicate]

        defaults = {:type => Gearbox::Types::Any}
        
        send(attributes_source)[getter_name] = defaults.merge(options)

        # Define a getter on the object
        define_method(getter_name) do
          self.class.yield_attr(getter_name, self)
        end

        # Define a setter on the object
        define_method("#{getter_name}=") do |value|
          self.class.store_attr(getter_name, self, value)
          # attribute = send(self.class.attributes_source)[getter_name]
        end

      end
      
      # Sets the attributes_source, where to store the attributes
      attr_writer :attributes_source
      
      # Gets the attributes_source...
      def attributes_source
        @attributes_source ||= :attribute_collection
      end

      def attribute_collection
        @attribute_collection ||= AttributeCollection.new
      end
      
      def yield_attr(getter_name, instance)
        if statement = instance.rdf_collection[getter_name]
          attribute_options = instance.class.attribute_collection[getter_name]
          type = attribute_options ? attribute_options.type : nil
          type ? type.unserialize(statement.object) : statement.object.to_s
        else
          attribute_options = send(attributes_source)[getter_name]
          attribute_options ? attribute_options.default : nil
        end
      end
      
      def store_attr(getter_name, instance, value)
        attribute_options = send(attributes_source)[getter_name]
        type = attribute_options.type
        value = type.serialize(value)  if type.respond_to?(:serialize)
        statement = RDF::Statement.new(instance.subject, attribute_options.predicate, value)
        instance.rdf_collection[getter_name] = statement
      end

    end
    
    module InstanceMethods
      # We collect triples inside the models in order to query them, filter them
      # and handle the bridge between domain models and the graph we're building.
      def rdf_collection
        @rdf_collection ||= RDFCollection.new
      end
      
      def subject
        # Will be updated...
        @subject ||= RDF::Node.new
      end
      
      # An initialization strategy for all occasions.
      def initialize(obj=nil)
        case obj
        when Hash
          merge_hash_values(obj)
        when RDFCollection
          merge_rdf_collection(obj)
        end
      end
      
      private
      
        def merge_hash_values(hash)
          # TODO: work with associations here...
          hash.each do |getter_name, value|
            setter_name = "#{getter_name}="
            send(setter_name, value) if respond_to?(setter_name)
            # What to do with the others?
          end
        end
        
        def merge_rdf_collection(collection)
          rdf_collection.merge!(collection)
        end
      
    end # InstanceMethods
    
  end # SemanticAccessors
end # Gearbox
