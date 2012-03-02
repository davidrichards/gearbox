module Gearbox
  
  ##
  # Collects attributes in a hash-like format.  Serializes the attributes in an OpenStruct.
  ##
  class AttributeCollection
    
    # Build a new AttributeCollection with an optional Hash.  
    # Note: this class normalizes the keys and creates OpenStructs for values.
    # @param [Hash] default A hash with normalized keys and OpenStruct values
    def initialize(default={})
      raise ArgumentError, "Must provide a hash for the defaults" unless default.is_a?(Hash)
      @default = default
      @source = {}
    end
    
    # Set one attribute in the collection.
    # @param [String, Symbol] key
    # @param [Hash] hash
    # @return [OpenStruct] The hash, converted into an OpenStruct
    def []=(key, hash)
      raise ArgumentError, "Must provide a hash for the value" unless hash.is_a?(Hash)
      @source[normalize_key(key)] = OpenStruct.new(@default.merge(hash))
    end
    
    # Get one attribute from the collection.
    # @param [String, Symbol] key
    # @return [OpenStruct, nil] Returns the attribute OpenStruct, if found.
    def [](key)
      @source[normalize_key(key)]
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