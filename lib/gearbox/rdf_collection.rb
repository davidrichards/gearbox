module Gearbox
  
  ##
  # Collects model values as RDF.  This is a key part of making SPARQL our primary
  # filtering, finding, and extension language.  
  ##
  class RDFCollection
    
    # ============
    # = Behavior =
    # ============
    include RDF::Enumerable
    
    def initialize
      @source = {}
    end
    
    # Enumerates on the RDF Statements.  Necessary for RDF::Enumerable to 
    # add all of the internal and external iterator goodies available there
    # (like each_subject and has_subject?).
    # @param [Block] block Optional block.  Creates an external iterator if omitted.
    # @return [nil, Enumerator] Returns either nil, or an external iterator.
    def each(&block)
      if block_given?
        @source.each(&block)
      else
        Enumerator.new(self, :each)
      end
    end
    
    # Set RDF::Statements to the underlying collection.  Normalizes the keys.
    # @param [String, Symbol] key
    # @param [RDF::Statement] obj.  RDF::Statement that will be added.
    def add_statement(key, obj)
      @source[normalize_key(key)] = obj if obj.is_a?(RDF::Statement)
    end
    alias :[]= :add_statement
    
    # Get RDF::Statement from the underlying collection.  Normalizes the key.
    # @param [String, Symbol] key.  Normalized.
    # @return [RDF::Statement, nil] Found statement, if it exists.
    def [](key)
      @source[normalize_key(key)]
    end
    
    # Lookup whether the key exists.
    # @param [String, Symbol] key 
    # @param [Hash, nil] opts.  :normalize => false will lookup the key as provided.
    # @return [Boolean]
    def has_key?(key, opts={})
      key = normalize_key(key) if opts.fetch(:normalize, true)
      @source.has_key?(key)
    end
    
    # Merges a hash of RDF::Statements into the underlying collection.
    # Uses the add_statement to filter the values of the hash.
    # @param [Hash] hash.  Collection of statements.
    # @return [nil]
    def merge!(hash)
      hash.each {|key, obj| add_statement(key, obj)}
    end
    
    private
      # Normalizes the key.  Converts to a lower case symbol with non-alpha-numerics
      # replaced by underscores, removing trailing and preceding underscores.
      # @private
      def normalize_key(obj)
        obj.to_s.downcase.gsub(/[^A-Za-z0-9_]+/, '_').gsub(/(_$)|(^_)/, '').to_sym
      end
    
  end
end
