module Gearbox
  class RDFCollection
    include RDF::Enumerable
    
    def initialize
      @source = {}
    end
    
    def each(&block)
      if block_given?
        @source.each(&block)
      else
        Enumerator.new(self, :each)
      end
    end
    
    def add_statement(key, obj)
      @source[normalize_key(key)] = obj if obj.is_a?(RDF::Statement)
    end
    alias :[]= :add_statement
    
    def [](key)
      @source[normalize_key(key)]
    end
    
    def has_key?(key, opts={})
      key = normalize_key(key) if opts.fetch(:normalize, true)
      @source.has_key?(key)
    end
    
    def merge!(hash)
      hash.each {|key, obj| add_statement(key, obj)}
    end
    
    private
      def normalize_key(obj)
        obj.to_s.downcase.gsub(/[^A-Za-z0-9_]+/, '_').gsub(/(_$)|(^_)/, '').to_sym
      end
    
  end
end
