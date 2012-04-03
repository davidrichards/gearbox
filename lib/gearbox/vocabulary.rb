



module Gearbox
=begin
  ##
  # Derived from RDF::Vocabulary
  # However, I have two new use cases for Gearbox::Vocabulary
  # * as a single source for an ontology
  # * as a base_uri in a model

  ## Single source Ontology
  Ontologies have classes and attributes.  That means there is some nesting in the vocabulary.
  We have this 

  * /:collection/:item/:sub-collection/:item
  * concatenating the existing identifier or key with a suitable base URI. 
  * /:collection/:id
  
  http://www.bbc.co.uk/music/artists/a74b1b7f-71a5-4011-9441-d0b5e4122711
  http://musicbrainz.org/artist/a74b1b7f-71a5-4011-9441-d0b5e4122711
  
  <http:www.example.org/category/heavy-metal>
    rdfs:label "Heavy Metal"
  
=end
  
  
  # But with some patterns in mind from http://patterns.dataincubator.org/book/


  class Vocabulary < RDF::Vocabulary
    
    # =================
    # = Class Methods =
    # =================
    
    class << self
      
      ##
      # Defines a vocabulary term called `property`.
      #
      # @param  [Symbol]
      # @return [void]
      def property(property, opts={})
        metaclass = class << self; self; end
        metaclass.send(:define_method, property) { self.lookup(property) } # class method
      end

      ##
      # Returns the URI for the term `property` in this vocabulary.
      #
      # @param  [#to_s] property
      # @return [RDF::URI]
      def [](property)
        RDF::URI.intern([to_s, property.to_s].join(''))
      end

      def lookup(property)

      end


      protected
        def create(uri) # @private
          @@uri = uri
          self
        end

        def inherited(subclass) # @private
          @@subclasses << subclass
          unless @@uri.nil?
            subclass.send(:private_class_method, :new)
            @@uris[subclass] = @@uri
            @@uri = nil
          end
          super
        end

        def method_missing(property, *args, &block)
          if args.empty? && @@uris.has_key?(self)
            self[property]
          else
            super
          end
        end
      
    end
    
    ##
    # @param  [RDF::URI, String, #to_s]
    def initialize(uri)
      @uri = case uri
        when RDF::URI then uri.to_s
        else RDF::URI.parse(uri.to_s) ? uri.to_s : nil
      end
    end

    ##
    # Returns the URI for the term `property` in this vocabulary.
    #
    # @param  [#to_s] property
    # @return [URI]
    def [](property)
      RDF::URI.intern([to_s, property.to_s].join(''))
    end

    ##
    # Returns the base URI for this vocabulary.
    #
    # @return [URI]
    def to_uri
      RDF::URI.intern(to_s)
    end

    ##
    # Returns a string representation of this vocabulary.
    #
    # @return [String]
    def to_s
      @uri.to_s
    end

    ##
    # Returns a developer-friendly representation of this vocabulary.
    #
    # @return [String]
    def inspect
      sprintf("#<%s:%#0x(%s)>", self.class.name, __id__, to_s)
    end

  protected

    def method_missing(property, *args, &block)
      if args.empty?
        self[property]
      else
        raise ArgumentError.new("wrong number of arguments (#{args.size} for 0)")
      end
    end

  private

    @@subclasses = [::RDF] # @private
    @@uris       = {}      # @private
    @@uri        = nil     # @private
  end # Vocabulary
end # RDF
