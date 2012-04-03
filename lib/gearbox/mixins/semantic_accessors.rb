module Gearbox
  
  # These are the attributes and associations that the user adds to a model.
  module SemanticAccessors

    def self.included(base)
      base.extend ClassMethods
      base.send :include, InstanceMethods
    end

    module ClassMethods
      
      def attributes
        @attributes ||= {}
      end
      
      def attribute(name, opts={})
        opts = opts.merge(:name => name)

        define_method(name) do
          attribute_definitions[name] ||= Attribute.new(opts)
          attribute_definitions[name].to_value
        end
        
        define_method("#{name}=") do |value|
          attribute_definitions[name] ||= Attribute.new(opts)
          attribute_definitions[name].set(value)
        end

        attributes[name] = opts
      end
    end
    
    module InstanceMethods

      def initialize(opts={})
        super
        assert_defaults
        assert_options(opts)
      end
      
      def attributes
        self.class.attributes.inject({:id => id}) do |hash, (name, opts)|
          hash[name] = send(name)
          hash
        end
      end
      
      private
      
      def assert_defaults
        self.class.attributes.each do |name, opts|
          next unless opts.has_key?(:default)
          setter = "#{name}="
          send(setter, opts[:default])
        end
      end
      
      def assert_options(opts)
        opts.each do |name, value|
          setter = "#{name}="
          send(setter, value) if respond_to?(setter)
        end
      end

      def attribute_definitions
        @attribute_definitions ||= {}
      end
      
    end
  end
end



# class Z
#   
#   # ============
#   # = Behavior =
#   # ============
#   include RDF::Queryable
#   include ActiveModel::Validations
#   include ActiveModel::Conversion
#   extend ActiveModel::Naming
#   
#   def self.attribute(name, opts={})
#     
#     opts = opts.merge(:name => name)
#     
#     define_method(name) do
#       attribute_definitions[name] ||= Attribute.new(opts)
#       attribute_definitions[name].to_value
#     end
#     
#     define_method("#{name}=") do |value|
#       attribute_definitions[name] ||= Attribute.new(opts)
#       attribute_definitions[name].set(value)
#     end
#     
#     attributes[name] = opts
#   end
#   
#   def self.attributes
#     @attributes ||= {}
#   end
#   
#   attribute :name, :predicate => RDF::FOAF.name
#   attribute :email, :predicate => RDF::FOAF.mbox
#   
#   def initialize(opts={})
#     assert_defaults
#     assert_options(opts)
#   end
#   
#   def id
#     @id ||= object_id
#   end
#   attr_writer :id
#   
#   def subject
#     "http://example.com/z/#{id}"
#   end
#   
#   def attributes
#     self.class.attributes.inject({:id => id}) do |hash, (name, opts)|
#       hash[name] = send(name)
#       hash
#     end
#   end
#   
#   def each(opts={}, &block)
#     attribute_definitions.map{|name, attribute| attribute.to_rdf(self, opts)}.each(&block)
#   end
#   
#   def inspect
#     "Z: #{name}"
#   end
#   
#   def persisted?
#     false
#   end
#   
#   private
#   
#   def assert_defaults
#   end
# 
#   def assert_options(opts)
#     opts.each do |accessor, value|
#       send("#{accessor}=", value) if respond_to?("#{accessor}=")
#     end
#   end
# 
#   def attribute_definitions
#     @attribute_definitions ||= {}
#   end
# end
