module Gearbox
  module SubjectMethods
    
    def self.included(base)
      base.extend ClassMethods
      base.send :include, InstanceMethods
    end

    module ClassMethods
      def base_uri(value=:_value_not_set)
        @base_uri = value unless value == :_value_not_set
        @base_uri
      end
      
      def id_method(value=:_value_not_set)
        @id_method = value unless value == :_value_not_set
        @id_method ||= :object_id
      end
      
      def subject_decorator(value=:_value_not_set)
        @subject_decorator = value unless value == :_value_not_set
        @subject_decorator
      end
      
    end
    
    module InstanceMethods
      
      attr_accessor :base_uri
      
      def initialize(opts={})
        super
        set_attributes_from_configuration_or_opts(opts, :base_uri, :id_method, :id, :subject_decorator)
      end
      
      def id
        return @id if @id
        send(id_method)
      end
      attr_writer :id
    
      # Gives us the ability to derive an id from other sources or patterns.
      # Based on the identifier patterns: http://patterns.dataincubator.org/book/
      attr_accessor :id_method
      
      # Allows patterns to be used to define the subject.
      attr_accessor :subject_decorator
      
      # subject_decorator -> internal method -> subject
      # subject_decorator -> lambda -> subject
      # (base_uri + (id_method -> id)) -> subject
      # There are several ways to create the subject.  First, the subject_decorator
      # will use whatever instance values that are set to build a pattern.
      # Second, the base_uri and id are combined to create the subject.  
      # Note, the id can be set directly, or set with the id_method, so UUID, 
      # or an external source, or a slug generating method can be used to generate
      # an id.
      def subject
        if subject_decorator
          derive_subject_from_decorator
        else
          derive_subject_from_base_uri_and_id
        end
      end
      
      private
      
      def derive_subject_from_decorator
        subject_decorator.respond_to?(:call) ? subject_decorator.call(self)
                                             : self.send(subject_decorator)
      end
      
      def derive_subject_from_base_uri_and_id
        File.join(base_uri.to_s, id.to_s)
      end
      
      def set_attributes_from_configuration_or_opts(opts, *attributes)
        attributes.each do |attribute|
          variable_name = "@#{attribute}"
          instance_variable_set(variable_name, self.class.send(attribute)) if self.class.respond_to?(attribute)
          instance_variable_set(variable_name, opts[attribute]) if opts.has_key?(attribute)
        end
      end
    end

    
  end
end
