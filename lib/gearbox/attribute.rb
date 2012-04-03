module Gearbox

  class Attribute
    
    # Options to figure out: more index options, routing, triple pattern
    attr_accessor :predicate, :reverse, :index, :name, :repository, :value, :language, :datatype
    attr_reader :subject_decorator
    
    def initialize(opts={})
      set(opts.delete(:value) || :_value_not_set)
      assert_defaults
      extract_from_statement(opts) if opts.has_key?(:statement)
      assert_options(opts)
    end
    
    def subject_decorator=(value=nil, &block)
      @subject_decorator = block_given? ? block : value
    end
    
    # TODO: I'm a little quesy about the relationship between the model class, the model, and the attribute.
    # I'm going to have to rebuild the model DSL and see how this stuff gets built.
    def subject
      return nil unless subject_decorator
      if subject_decorator.respond_to?(:call)
        subject_decorator.call()
      elsif respond_to?(subject_decorator)
        self.send(subject_decorator)
      else
        nil
      end
    end
    
    def to_value
      # Skipping the serialization steps for a moment.
      @value
    end
    alias :get :to_value
    
    def literal(opts={:value => :_value_not_set})
      value = opts.delete(:value)
      value = to_value if value == :_value_not_set
      opts = {:language => self.language, :datatype => self.datatype}.merge(opts)
      value = case opts[:datatype]
      when :boolean
        RDF::Literal::Boolean.new(value)
      when :date
        RDF::Literal::Date.new(value)
      when :date_time
        RDF::Literal::DateTime.new(value)
      when :decimal
        RDF::Literal::Decimal.new(value)
      when :double
        RDF::Literal::Double.new(value)
      when :time
        RDF::Literal::Time.new(value)
      when :token
        RDF::Literal::Token.new(value)
      when :xml
        RDF::Literal::XML.new(value)
      else
        value
      end
        
      RDF::Literal.new(value, opts)
    end
    
    def set(value=:_value_not_set, opts={})
      opts = {:value => value}.merge(opts)
      @value = literal(opts).object
    end

    def to_rdf(model, opts={})
      opts[:value] = :_value_not_set unless opts.has_key?(:value)
      opts = {
        :reverse => self.reverse, 
        :predicate => self.predicate, 
        :value => self.literal(opts)
      }.merge(opts)
      
      subject = self.subject
      subject ||= model.subject
      subject = RDF::URI.new(subject)
      predicate = opts[:predicate]
      object = opts[:value]
      
      return opts[:reverse] ? RDF::Statement(object, predicate, subject)
                     : RDF::Statement(subject, predicate, object)
    end
    
    private
    
      def assert_defaults
        self.index = false
        self.reverse = false
      end
      
      def assert_options(opts)
        opts.each do |accessor, value|
          send("#{accessor}=", value) if respond_to?("#{accessor}=")
        end
      end
      
      def extract_from_statement(opts)
        statement = opts[:statement]
        object = statement.object

        self.reverse = can_infer_reverse_from_model?(opts[:model], object)
        object = statement.subject if self.reverse

        self.predicate = statement.predicate
        self.set extract_from_literal(object)
      end
      
      def extract_from_literal(literal)
        return literal unless literal.is_a?(RDF::Literal)
        self.language = literal.language
        self.datatype = literal.datatype
        literal.object 
      end
      
      def can_infer_reverse_from_model?(model, object)
        return false unless model
        model.subject.to_s == object.to_s
      end
  end
  
end

